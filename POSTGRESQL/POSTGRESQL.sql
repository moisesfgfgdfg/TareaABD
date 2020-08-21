/*==============================================================*/
/* Table: ABONOFACTURA                                          */
/*==============================================================*/
create table ABONOFACTURA (
   IDABONO              INT4                 not null,
   RUCCLIENTE           INT4                 not null,
   NUMFACT              INT4                 not null,
   MONTO                INT4                 null,
   FECHAMONTO           DATE                 null,
   constraint PK_ABONOFACTURA primary key (IDABONO)
);

/*==============================================================*/
/* Index: ABONOFACTURA_PK                                       */
/*==============================================================*/
create unique index ABONOFACTURA_PK on ABONOFACTURA (
IDABONO
);

/*==============================================================*/
/* Index: CLIENTE_ABONO_FK                                      */
/*==============================================================*/
create  index CLIENTE_ABONO_FK on ABONOFACTURA (
RUCCLIENTE
);

/*==============================================================*/
/* Index: ABONO_FACTURA_FK                                      */
/*==============================================================*/
create  index ABONO_FACTURA_FK on ABONOFACTURA (
NUMFACT
);

/*==============================================================*/
/* Table: CLIENTES                                              */
/*==============================================================*/
create table CLIENTES (
   RUCCLIENTE           INT4                 not null,
   NOMBRES              VARCHAR(40)          null,
   TELEFONO             INT4                 null,
   CORREO               VARCHAR(30)          null,
   constraint PK_CLIENTES primary key (RUCCLIENTE)
);

/*==============================================================*/
/* Index: CLIENTES_PK                                           */
/*==============================================================*/
create unique index CLIENTES_PK on CLIENTES (
RUCCLIENTE
);

/*==============================================================*/
/* Table: FACTURA                                               */
/*==============================================================*/
create table FACTURA (
   NUMFACT              INT4                 not null,
   RUCCLIENTE           INT4                 not null,
   IDSERVICIO           INT4                 not null,
   FECHAFACT            DATE                 null,
   SUBTOTAL             INT4                 null,
   IVA                  INT4                 null,
   TOTALFACT            INT4                 null,
   constraint PK_FACTURA primary key (NUMFACT)
);

/*==============================================================*/
/* Index: FACTURA_PK                                            */
/*==============================================================*/
create unique index FACTURA_PK on FACTURA (
NUMFACT
);

/*==============================================================*/
/* Index: CLIENTE_VENTA_FK                                      */
/*==============================================================*/
create  index CLIENTE_VENTA_FK on FACTURA (
RUCCLIENTE
);

/*==============================================================*/
/* Index: VENTA_FACTURA_FK                                      */
/*==============================================================*/
create  index VENTA_FACTURA_FK on FACTURA (
IDSERVICIO
);

/*==============================================================*/
/* Table: SERVICIO_MORTUORIO                                    */
/*==============================================================*/
create table SERVICIO_MORTUORIO (
   IDSERVICIO           INT4                 not null,
   NOMBRESERVICIO       VARCHAR(20)          null,
   PRECIO               INT4                 null,
   DESCRIPCION          VARCHAR(50)          null,
   constraint PK_SERVICIO_MORTUORIO primary key (IDSERVICIO)
);

/*==============================================================*/
/* Index: SERVICIO_MORTUORIO_PK                                 */
/*==============================================================*/
create unique index SERVICIO_MORTUORIO_PK on SERVICIO_MORTUORIO (
IDSERVICIO
);

alter table ABONOFACTURA
   add constraint FK_ABONOFAC_ABONO_FAC_FACTURA foreign key (NUMFACT)
      references FACTURA (NUMFACT)
      on delete restrict on update restrict;

alter table ABONOFACTURA
   add constraint FK_ABONOFAC_CLIENTE_A_CLIENTES foreign key (RUCCLIENTE)
      references CLIENTES (RUCCLIENTE)
      on delete restrict on update restrict;

alter table FACTURA
   add constraint FK_FACTURA_CLIENTE_V_CLIENTES foreign key (RUCCLIENTE)
      references CLIENTES (RUCCLIENTE)
      on delete restrict on update restrict;

alter table FACTURA
   add constraint FK_FACTURA_VENTA_FAC_SERVICIO foreign key (IDSERVICIO)
      references SERVICIO_MORTUORIO (IDSERVICIO)
      on delete restrict on update restrict;

