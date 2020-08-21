/*==============================================================*/
/* Table: ABONOFACTURA                                          */
/*==============================================================*/
create table ABONOFACTURA 
(
   IDABONO              INTEGER              not null,
   RUCCLIENTE           INTEGER              not null,
   NUMFACT              INTEGER              not null,
   MONTO                INTEGER,
   FECHAMONTO           DATE,
   constraint PK_ABONOFACTURA primary key (IDABONO)
);

/*==============================================================*/
/* Index: CLIENTE_ABONO_FK                                      */
/*==============================================================*/
create index CLIENTE_ABONO_FK on ABONOFACTURA (
   RUCCLIENTE ASC
);

/*==============================================================*/
/* Index: ABONO_FACTURA_FK                                      */
/*==============================================================*/
create index ABONO_FACTURA_FK on ABONOFACTURA (
   NUMFACT ASC
);

/*==============================================================*/
/* Table: CLIENTES                                              */
/*==============================================================*/
create table CLIENTES 
(
   RUCCLIENTE           INTEGER              not null,
   NOMBRES              VARCHAR2(40),
   TELEFONO             INTEGER,
   CORREO               VARCHAR2(30),
   constraint PK_CLIENTES primary key (RUCCLIENTE)
);

/*==============================================================*/
/* Table: FACTURA                                               */
/*==============================================================*/
create table FACTURA 
(
   NUMFACT              INTEGER              not null,
   RUCCLIENTE           INTEGER              not null,
   IDSERVICIO           INTEGER              not null,
   FECHAFACT            DATE,
   SUBTOTAL             INTEGER,
   IVA                  INTEGER,
   TOTALFACT            INTEGER,
   constraint PK_FACTURA primary key (NUMFACT)
);

/*==============================================================*/
/* Index: CLIENTE_VENTA_FK                                      */
/*==============================================================*/
create index CLIENTE_VENTA_FK on FACTURA (
   RUCCLIENTE ASC
);

/*==============================================================*/
/* Index: VENTA_FACTURA_FK                                      */
/*==============================================================*/
create index VENTA_FACTURA_FK on FACTURA (
   IDSERVICIO ASC
);

/*==============================================================*/
/* Table: SERVICIO_MORTUORIO                                    */
/*==============================================================*/
create table SERVICIO_MORTUORIO 
(
   IDSERVICIO           INTEGER              not null,
   NOMBRESERVICIO       VARCHAR2(20),
   PRECIO               INTEGER,
   DESCRIPCION          VARCHAR2(50),
   constraint PK_SERVICIO_MORTUORIO primary key (IDSERVICIO)
);

alter table ABONOFACTURA
   add constraint FK_ABONOFAC_ABONO_FAC_FACTURA foreign key (NUMFACT)
      references FACTURA (NUMFACT);

alter table ABONOFACTURA
   add constraint FK_ABONOFAC_CLIENTE_A_CLIENTES foreign key (RUCCLIENTE)
      references CLIENTES (RUCCLIENTE);

alter table FACTURA
   add constraint FK_FACTURA_CLIENTE_V_CLIENTES foreign key (RUCCLIENTE)
      references CLIENTES (RUCCLIENTE);

alter table FACTURA
   add constraint FK_FACTURA_VENTA_FAC_SERVICIO foreign key (IDSERVICIO)
      references SERVICIO_MORTUORIO (IDSERVICIO);

