/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     19/08/2020 20:28:20                          */
/*==============================================================*/

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ABONOFACTURA') and o.name = 'FK_ABONOFAC_ABONO_FAC_FACTURA')
alter table ABONOFACTURA
   drop constraint FK_ABONOFAC_ABONO_FAC_FACTURA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ABONOFACTURA') and o.name = 'FK_ABONOFAC_CLIENTE_A_CLIENTES')
alter table ABONOFACTURA
   drop constraint FK_ABONOFAC_CLIENTE_A_CLIENTES
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('FACTURA') and o.name = 'FK_FACTURA_CLIENTE_V_CLIENTES')
alter table FACTURA
   drop constraint FK_FACTURA_CLIENTE_V_CLIENTES
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('FACTURA') and o.name = 'FK_FACTURA_VENTA_FAC_SERVICIO')
alter table FACTURA
   drop constraint FK_FACTURA_VENTA_FAC_SERVICIO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ABONOFACTURA')
            and   name  = 'ABONO_FACTURA_FK'
            and   indid > 0
            and   indid < 255)
   drop index ABONOFACTURA.ABONO_FACTURA_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ABONOFACTURA')
            and   name  = 'CLIENTE_ABONO_FK'
            and   indid > 0
            and   indid < 255)
   drop index ABONOFACTURA.CLIENTE_ABONO_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ABONOFACTURA')
            and   type = 'U')
   drop table ABONOFACTURA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CLIENTES')
            and   type = 'U')
   drop table CLIENTES
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('FACTURA')
            and   name  = 'VENTA_FACTURA_FK'
            and   indid > 0
            and   indid < 255)
   drop index FACTURA.VENTA_FACTURA_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('FACTURA')
            and   name  = 'CLIENTE_VENTA_FK'
            and   indid > 0
            and   indid < 255)
   drop index FACTURA.CLIENTE_VENTA_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('FACTURA')
            and   type = 'U')
   drop table FACTURA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SERVICIO_MORTUORIO')
            and   type = 'U')
   drop table SERVICIO_MORTUORIO
go

/*==============================================================*/
/* Table: ABONOFACTURA                                          */
/*==============================================================*/
create table ABONOFACTURA (
   IDABONO              int                  not null,
   RUCCLIENTE           int                  not null,
   NUMFACT              int                  not null,
   MONTO                int                  null,
   FECHAMONTO           datetime             null,
   constraint PK_ABONOFACTURA primary key (IDABONO)
)
go

/*==============================================================*/
/* Index: CLIENTE_ABONO_FK                                      */
/*==============================================================*/
create index CLIENTE_ABONO_FK on ABONOFACTURA (
RUCCLIENTE ASC
)
go

/*==============================================================*/
/* Index: ABONO_FACTURA_FK                                      */
/*==============================================================*/
create index ABONO_FACTURA_FK on ABONOFACTURA (
NUMFACT ASC
)
go

/*==============================================================*/
/* Table: CLIENTES                                              */
/*==============================================================*/
create table CLIENTES (
   RUCCLIENTE           int                  not null,
   NOMBRES              varchar(40)          null,
   TELEFONO             int                  null,
   CORREO               varchar(30)          null,
   constraint PK_CLIENTES primary key (RUCCLIENTE)
)
go

/*==============================================================*/
/* Table: FACTURA                                               */
/*==============================================================*/
create table FACTURA (
   NUMFACT              int                  not null,
   RUCCLIENTE           int                  not null,
   IDSERVICIO           int                  not null,
   FECHAFACT            datetime             null,
   SUBTOTAL             int                  null,
   IVA                  int                  null,
   TOTALFACT            int                  null,
   constraint PK_FACTURA primary key (NUMFACT)
)
go

/*==============================================================*/
/* Index: CLIENTE_VENTA_FK                                      */
/*==============================================================*/
create index CLIENTE_VENTA_FK on FACTURA (
RUCCLIENTE ASC
)
go

/*==============================================================*/
/* Index: VENTA_FACTURA_FK                                      */
/*==============================================================*/
create index VENTA_FACTURA_FK on FACTURA (
IDSERVICIO ASC
)
go

/*==============================================================*/
/* Table: SERVICIO_MORTUORIO                                    */
/*==============================================================*/
create table SERVICIO_MORTUORIO (
   IDSERVICIO           int                  not null,
   NOMBRESERVICIO       varchar(20)          null,
   PRECIO               int                  null,
   DESCRIPCION          varchar(50)          null,
   constraint PK_SERVICIO_MORTUORIO primary key (IDSERVICIO)
)
go

alter table ABONOFACTURA
   add constraint FK_ABONOFAC_ABONO_FAC_FACTURA foreign key (NUMFACT)
      references FACTURA (NUMFACT)
go

alter table ABONOFACTURA
   add constraint FK_ABONOFAC_CLIENTE_A_CLIENTES foreign key (RUCCLIENTE)
      references CLIENTES (RUCCLIENTE)
go

alter table FACTURA
   add constraint FK_FACTURA_CLIENTE_V_CLIENTES foreign key (RUCCLIENTE)
      references CLIENTES (RUCCLIENTE)
go

alter table FACTURA
   add constraint FK_FACTURA_VENTA_FAC_SERVICIO foreign key (IDSERVICIO)
      references SERVICIO_MORTUORIO (IDSERVICIO)
go

