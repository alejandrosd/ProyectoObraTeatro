/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     25/03/2022 6:12:10 p.�m.                     */
/*==============================================================*/


alter table ASISTENCIAESTUDIANTE
   drop constraint FK_ASISTENC_RELATIONS_ESTUDIAN;

alter table ASISTENCIAESTUDIANTE
   drop constraint FK_ASISTENC_RELATIONS_CALENDAR;

alter table CALENDARIO
   drop constraint FK_CALENDAR_RELATIONS_TEATRO;

alter table CALENDARIO
   drop constraint FK_CALENDAR_RELATIONS_OBRA;

alter table CALENDARIO
   drop constraint FK_CALENDAR_RELATIONS_HORAFECH;

alter table CALENDARIO
   drop constraint FK_CALENDAR_RELATIONS_TIPOCALE;

alter table CALENDARIO
   drop constraint FK_CALENDAR_RELATIONS_HORAFEC2;

alter table DRAMATURGO
   drop constraint FK_DRAMATUR_RELATIONS_PAIS;

alter table EMPLEADO
   drop constraint FK_EMPLEADO_PERTENECE_UNIDAD;

alter table ESTUDIANTE
   drop constraint FK_ESTUDIAN_RELATIONS_UNIDAD;

alter table GASTOOBRA
   drop constraint FK_GASTOOBR_RELATIONS_OBRA;

alter table GASTOOBRA
   drop constraint FK_GASTOOBR_RELATIONS_LISTAGAS;

alter table LABORPERSONALOBRA
   drop constraint FK_LABORPER_RELATIONS_LISTAACT;

alter table LABORPERSONALOBRA
   drop constraint FK_LABORPER_RELATIONS_PERSONAL;

alter table LABORPERSONALOBRA
   drop constraint FK_LABORPER_RELATIONS_CALENDAR;

alter table LISTAACTIVIDAD
   drop constraint FK_LISTAACT_RELATIONS_PERIODO;

alter table LISTAGASTO
   drop constraint FK_LISTAGAS_RELATIONS_PERIODO;

alter table OBRA
   drop constraint FK_OBRA_FUE_CREAD_PAIS;

alter table OBRA
   drop constraint FK_OBRA_RELATIONS_DRAMATUR;

alter table OBRA
   drop constraint FK_OBRA_TIENE4_TIPOOBRA;

alter table PERSONAJE
   drop constraint FK_PERSONAJ_TIENE3_OBRA;

alter table PERSONAJEESTUDIANTE
   drop constraint FK_PERSONAJ_TIENE_ESTUDIAN;

alter table PERSONAJEESTUDIANTE
   drop constraint FK_PERSONAJ_UTILIZA_PERSONAJ;

alter table PERSONALOBRA
   drop constraint FK_PERSONAL_RELATIONS_EMPLEADO;

alter table PERSONALOBRA
   drop constraint FK_PERSONAL_RELATIONS_ROL;

alter table PERSONALOBRA
   drop constraint FK_PERSONAL_TIENE45_OBRA;

alter table UNIDAD
   drop constraint FK_UNIDAD_RELATIONS_UNIDAD;

alter table UNIDAD
   drop constraint FK_UNIDAD_RELATIONS_TIPOUNID;

drop index RELATIONSHIP_32_FK;

drop index RELATIONSHIP_31_FK;

drop table ASISTENCIAESTUDIANTE cascade constraints;

drop index RELATIONSHIP_39_FK;

drop index RELATIONSHIP_36_FK;

drop index RELATIONSHIP_35_FK;

drop index RELATIONSHIP_34_FK;

drop index RELATIONSHIP_33_FK;

drop table CALENDARIO cascade constraints;

drop index RELATIONSHIP_20_FK;

drop table DRAMATURGO cascade constraints;

drop index PERTENECE_FK;

drop table EMPLEADO cascade constraints;

drop index RELATIONSHIP_21_FK;

drop table ESTUDIANTE cascade constraints;

drop index RELATIONSHIP_25_FK;

drop index RELATIONSHIP_24_FK;

drop table GASTOOBRA cascade constraints;

drop table HORAFECHA cascade constraints;

drop index RELATIONSHIP_38_FK;

drop index RELATIONSHIP_37_FK;

drop index RELATIONSHIP_28_FK;

drop table LABORPERSONALOBRA cascade constraints;

drop index RELATIONSHIP_27_FK;

drop table LISTAACTIVIDAD cascade constraints;

drop index RELATIONSHIP_26_FK;

drop table LISTAGASTO cascade constraints;

drop index RELATIONSHIP_19_FK;

drop index FUE_CREADA_FK;

drop index TIENE4_FK;

drop table OBRA cascade constraints;

drop table PAIS cascade constraints;

drop table PERIODO cascade constraints;

drop index TIENE3_FK;

drop table PERSONAJE cascade constraints;

drop index TIENE_FK;

drop index UTILIZA_FK;

drop table PERSONAJEESTUDIANTE cascade constraints;

drop index RELATIONSHIP_30_FK;

drop index RELATIONSHIP_29_FK;

drop index TIENE45_FK;

drop table PERSONALOBRA cascade constraints;

drop table ROL cascade constraints;

drop table TEATRO cascade constraints;

drop table TIPOCALENDARIO cascade constraints;

drop table TIPOOBRA cascade constraints;

drop table TIPOUNIDAD cascade constraints;

drop index RELATIONSHIP_23_FK;

drop index RELATIONSHIP_22_FK;

drop table UNIDAD cascade constraints;

/*==============================================================*/
/* Table: ASISTENCIAESTUDIANTE                                  */
/*==============================================================*/
create table ASISTENCIAESTUDIANTE 
(
   IDASISTENCIAESTUDIANTE NUMBER(5)            not null,
   IDCALENDARIO         NUMBER(5)            not null,
   IDOBRA               VARCHAR2(4)          not null,
   IDESTUDIANTE         VARCHAR2(10)         not null,
   constraint PK_ASISTENCIAESTUDIANTE primary key (IDASISTENCIAESTUDIANTE)
);

/*==============================================================*/
/* Index: RELATIONSHIP_31_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_31_FK on ASISTENCIAESTUDIANTE (
   IDESTUDIANTE ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_32_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_32_FK on ASISTENCIAESTUDIANTE (
   IDCALENDARIO ASC,
   IDOBRA ASC
);

/*==============================================================*/
/* Table: CALENDARIO                                            */
/*==============================================================*/
create table CALENDARIO 
(
   IDCALENDARIO         NUMBER(5)            not null,
   IDOBRA               VARCHAR2(4)          not null,
   IDTIPOCALENDARIO     VARCHAR2(4)          not null,
   IDTEATRO             VARCHAR2(4)          not null,
   IDHORAINICIO         NUMBER(5)                 not null,
   IDHORAFIN            NUMBER(5)                 not null,
   constraint PK_CALENDARIO primary key (IDCALENDARIO, IDOBRA)
);

/*==============================================================*/
/* Index: RELATIONSHIP_33_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_33_FK on CALENDARIO (
   IDTEATRO ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_34_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_34_FK on CALENDARIO (
   IDOBRA ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_35_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_35_FK on CALENDARIO (
   IDHORAINICIO ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_36_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_36_FK on CALENDARIO (
   IDTIPOCALENDARIO ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_39_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_39_FK on CALENDARIO (
   IDHORAFIN ASC
);

/*==============================================================*/
/* Table: DRAMATURGO                                            */
/*==============================================================*/
create table DRAMATURGO 
(
   IDDRAMATURGO         VARCHAR2(4)          not null,
   NOMBRE               VARCHAR2(30)         not null,
   CODPAIS              VARCHAR2(4)          not null,
   constraint PK_DRAMATURGO primary key (IDDRAMATURGO)
);

/*==============================================================*/
/* Index: RELATIONSHIP_20_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_20_FK on DRAMATURGO (
   CODPAIS ASC
);

/*==============================================================*/
/* Table: EMPLEADO                                              */
/*==============================================================*/
create table EMPLEADO 
(
   IDEMPLEADO           VARCHAR2(4)          not null,
   IDUNIDAD             VARCHAR2(4)          not null,
   NOMBRE               VARCHAR2(40)         not null,
   APELLIDO             VARCHAR2(40)         not null,
   CEDULA               VARCHAR2(10)         not null,
   CELULAR              VARCHAR2(15)         not null,
   CORREO               VARCHAR2(100)        not null,
   constraint PK_EMPLEADO primary key (IDEMPLEADO, IDUNIDAD)
);

/*==============================================================*/
/* Index: PERTENECE_FK                                          */
/*==============================================================*/
create index PERTENECE_FK on EMPLEADO (
   IDUNIDAD ASC
);

/*==============================================================*/
/* Table: ESTUDIANTE                                            */
/*==============================================================*/
create table ESTUDIANTE 
(
   IDESTUDIANTE         VARCHAR2(10)         not null,
   IDUNIDAD             VARCHAR2(4)          not null,
   FECHAINSCRIPCION     DATE                 not null,
   FECHANACIMIENTO      DATE                 not null,
   CORREO               VARCHAR2(30)         not null,
   NOMBRE               VARCHAR2(50)         not null,
   APELLIDO             VARCHAR2(50)         not null,
   constraint PK_ESTUDIANTE primary key (IDESTUDIANTE)
);

/*==============================================================*/
/* Index: RELATIONSHIP_21_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_21_FK on ESTUDIANTE (
   IDUNIDAD ASC
);

/*==============================================================*/
/* Table: GASTOOBRA                                             */
/*==============================================================*/
create table GASTOOBRA 
(
   IDGASTOOBRA          NUMBER(5)            not null,
   IDLISTAGASTO         VARCHAR2(4)          not null,
   IDPERIODO            NUMBER(5)            not null,
   IDOBRA               VARCHAR2(4)          not null,
   FECHAGASTO           DATE                 not null,
   constraint PK_GASTOOBRA primary key (IDGASTOOBRA, IDLISTAGASTO, IDPERIODO)
);

/*==============================================================*/
/* Index: RELATIONSHIP_24_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_24_FK on GASTOOBRA (
   IDOBRA ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_25_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_25_FK on GASTOOBRA (
   IDLISTAGASTO ASC,
   IDPERIODO ASC
);

/*==============================================================*/
/* Table: HORAFECHA                                             */
/*==============================================================*/
create table HORAFECHA 
(
   IDHORAFECHA number(5) not null,
   FECHA date not null,
   constraint PK_HORAFECHA primary key (IDHORAFECHA)
);

/*==============================================================*/
/* Table: LABORPERSONALOBRA                                     */
/*==============================================================*/
create table LABORPERSONALOBRA 
(
   IDLABORPERSONALOBRA  NUMBER(5)            not null,
   IDPERSONALOBRA       NUMBER(5),
   IDEMPLEADO           VARCHAR2(4),
   IDUNIDAD             VARCHAR2(4),
   IDLISTAACTIVIDAD     VARCHAR2(4)          not null,
   IDPERIODO            NUMBER(5)            not null,
   IDCALENDARIO         NUMBER(5),
   IDOBRA               VARCHAR2(4),
   constraint PK_LABORPERSONALOBRA primary key (IDLABORPERSONALOBRA)
);

/*==============================================================*/
/* Index: RELATIONSHIP_28_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_28_FK on LABORPERSONALOBRA (
   IDLISTAACTIVIDAD ASC,
   IDPERIODO ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_37_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_37_FK on LABORPERSONALOBRA (
   IDPERSONALOBRA ASC,
   IDEMPLEADO ASC,
   IDUNIDAD ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_38_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_38_FK on LABORPERSONALOBRA (
   IDCALENDARIO ASC,
   IDOBRA ASC
);

/*==============================================================*/
/* Table: LISTAACTIVIDAD                                        */
/*==============================================================*/
create table LISTAACTIVIDAD 
(
   IDLISTAACTIVIDAD     VARCHAR2(4)          not null,
   IDPERIODO            NUMBER(5)            not null,
   DESCACTIVIDAD        VARCHAR2(40)         not null,
   VALORHORA            NUMBER(4,2)          not null,
   constraint PK_LISTAACTIVIDAD primary key (IDLISTAACTIVIDAD, IDPERIODO)
);

/*==============================================================*/
/* Index: RELATIONSHIP_27_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_27_FK on LISTAACTIVIDAD (
   IDPERIODO ASC
);

/*==============================================================*/
/* Table: LISTAGASTO                                            */
/*==============================================================*/
create table LISTAGASTO 
(
   IDLISTAGASTO         VARCHAR2(4)          not null,
   IDPERIODO            NUMBER(5)            not null,
   constraint PK_LISTAGASTO primary key (IDLISTAGASTO, IDPERIODO)
);

/*==============================================================*/
/* Index: RELATIONSHIP_26_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_26_FK on LISTAGASTO (
   IDPERIODO ASC
);

/*==============================================================*/
/* Table: OBRA                                                  */
/*==============================================================*/
create table OBRA 
(
   IDOBRA               VARCHAR2(4)          not null,
   TITULO               VARCHAR2(30)         not null,
   IDDRAMATURGO         VARCHAR2(4)          not null,
   FECHAOBRA            DATE                 not null,
   CODPAIS              VARCHAR2(4)          not null,
   IDTIPOOBRA           VARCHAR2(4)          not null,
   ESTADO               number(5)             not null,
   constraint PK_OBRA primary key (IDOBRA)
);

/*==============================================================*/
/* Index: TIENE4_FK                                             */
/*==============================================================*/
create index TIENE4_FK on OBRA (
   IDTIPOOBRA ASC
);

/*==============================================================*/
/* Index: FUE_CREADA_FK                                         */
/*==============================================================*/
create index FUE_CREADA_FK on OBRA (
   CODPAIS ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_19_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_19_FK on OBRA (
   IDDRAMATURGO ASC
);

/*==============================================================*/
/* Table: PAIS                                                  */
/*==============================================================*/
create table PAIS 
(
   CODPAIS              VARCHAR2(4)          not null,
   NOMBRE               VARCHAR2(30)         not null,
   constraint PK_PAIS primary key (CODPAIS)
);

/*==============================================================*/
/* Table: PERIODO                                               */
/*==============================================================*/
create table PERIODO 
(
   IDPERIODO            NUMBER(5)            not null,
   DESCPERIODO          VARCHAR2(40),
   constraint PK_PERIODO primary key (IDPERIODO)
);

/*==============================================================*/
/* Table: PERSONAJE                                             */
/*==============================================================*/
create table PERSONAJE 
(
   IDPERSONAJE          VARCHAR2(4)          not null,
   IDOBRA               VARCHAR2(4)          not null,
   NOMBRE               VARCHAR2(20)         not null,
   DESPERSONAJE         VARCHAR2(30)         not null,
   constraint PK_PERSONAJE primary key (IDPERSONAJE, IDOBRA)
);

/*==============================================================*/
/* Index: TIENE3_FK                                             */
/*==============================================================*/
create index TIENE3_FK on PERSONAJE (
   IDOBRA ASC
);

/*==============================================================*/
/* Table: PERSONAJEESTUDIANTE                                   */
/*==============================================================*/
create table PERSONAJEESTUDIANTE 
(
   IDPERSONAJEESTUDIANTE NUMBER(3)            not null,
   IDPERSONAJE          VARCHAR2(4)          not null,
   IDOBRA               VARCHAR2(4)          not null,
   IDESTUDIANTE         VARCHAR2(10)         not null,
   HORAINICIO           DATE                 not null,
   HORAFIN              DATE                 not null,
   constraint PK_PERSONAJEESTUDIANTE primary key (IDPERSONAJEESTUDIANTE)
);

/*==============================================================*/
/* Index: UTILIZA_FK                                            */
/*==============================================================*/
create index UTILIZA_FK on PERSONAJEESTUDIANTE (
   IDPERSONAJE ASC,
   IDOBRA ASC
);

/*==============================================================*/
/* Index: TIENE_FK                                              */
/*==============================================================*/
create index TIENE_FK on PERSONAJEESTUDIANTE (
   IDESTUDIANTE ASC
);

/*==============================================================*/
/* Table: PERSONALOBRA                                          */
/*==============================================================*/
create table PERSONALOBRA 
(
   IDPERSONALOBRA       NUMBER(5)            not null,
   IDEMPLEADO           VARCHAR2(4)          not null,
   IDUNIDAD             VARCHAR2(4)          not null,
   IDROL                VARCHAR2(4),
   IDOBRA               VARCHAR2(4),
   FECHAINICIO          DATE                 not null,
   FECHAFIN             DATE,
   constraint PK_PERSONALOBRA primary key (IDPERSONALOBRA, IDEMPLEADO, IDUNIDAD)
);

/*==============================================================*/
/* Index: TIENE45_FK                                            */
/*==============================================================*/
create index TIENE45_FK on PERSONALOBRA (
   IDOBRA ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_29_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_29_FK on PERSONALOBRA (
   IDEMPLEADO ASC,
   IDUNIDAD ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_30_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_30_FK on PERSONALOBRA (
   IDROL ASC
);

/*==============================================================*/
/* Table: ROL                                                   */
/*==============================================================*/
create table ROL 
(
   IDROL                VARCHAR2(4)          not null,
   NOMBRE               VARCHAR2(15)         not null,
   constraint PK_ROL primary key (IDROL)
);

/*==============================================================*/
/* Table: TEATRO                                                */
/*==============================================================*/
create table TEATRO 
(
   IDTEATRO             VARCHAR2(4)          not null,
   NOMBRE               VARCHAR2(20)         not null,
   DIRECCION            VARCHAR2(50)         not null,
   constraint PK_TEATRO primary key (IDTEATRO)
);

/*==============================================================*/
/* Table: TIPOCALENDARIO                                        */
/*==============================================================*/
create table TIPOCALENDARIO 
(
   IDTIPOCALENDARIO     VARCHAR2(4)          not null,
   DESCTIPOCALENDARIO   VARCHAR2(40)         not null,
   constraint PK_TIPOCALENDARIO primary key (IDTIPOCALENDARIO)
);

/*==============================================================*/
/* Table: TIPOOBRA                                              */
/*==============================================================*/
create table TIPOOBRA 
(
   IDTIPOOBRA           VARCHAR2(4)          not null,
   NOMBRE               VARCHAR2(15)         not null,
   constraint PK_TIPOOBRA primary key (IDTIPOOBRA)
);

/*==============================================================*/
/* Table: TIPOUNIDAD                                            */
/*==============================================================*/
create table TIPOUNIDAD 
(
   IDTIPOUNIDAD         VARCHAR2(4)          not null,
   DESCTIPO             VARCHAR2(40)         not null,
   constraint PK_TIPOUNIDAD primary key (IDTIPOUNIDAD)
);

/*==============================================================*/
/* Table: UNIDAD                                                */
/*==============================================================*/
create table UNIDAD 
(
   IDUNIDAD             VARCHAR2(4)          not null,
   IDTIPOUNIDAD         VARCHAR2(4)          not null,
   UNI_IDUNIDAD         VARCHAR2(4),
   NOMBRE               VARCHAR2(40)         not null,
   constraint PK_UNIDAD primary key (IDUNIDAD)
);

/*==============================================================*/
/* Index: RELATIONSHIP_22_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_22_FK on UNIDAD (
   UNI_IDUNIDAD ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_23_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_23_FK on UNIDAD (
   IDTIPOUNIDAD ASC
);

alter table ASISTENCIAESTUDIANTE
   add constraint FK_ASISTENC_RELATIONS_ESTUDIAN foreign key (IDESTUDIANTE)
      references ESTUDIANTE (IDESTUDIANTE);

alter table ASISTENCIAESTUDIANTE
   add constraint FK_ASISTENC_RELATIONS_CALENDAR foreign key (IDCALENDARIO, IDOBRA)
      references CALENDARIO (IDCALENDARIO, IDOBRA);

alter table CALENDARIO
   add constraint FK_CALENDAR_RELATIONS_TEATRO foreign key (IDTEATRO)
      references TEATRO (IDTEATRO);

alter table CALENDARIO
   add constraint FK_CALENDAR_RELATIONS_OBRA foreign key (IDOBRA)
      references OBRA (IDOBRA);

alter table CALENDARIO
   add constraint FK_CALENDAR_RELATIONS_HORAFECH foreign key (IDHORAINICIO)
      references HORAFECHA (IDHORAFECHA);

alter table CALENDARIO
   add constraint FK_CALENDAR_RELATIONS_TIPOCALE foreign key (IDTIPOCALENDARIO)
      references TIPOCALENDARIO (IDTIPOCALENDARIO);

alter table CALENDARIO
   add constraint FK_CALENDAR_RELATIONS_HORAFEC2 foreign key (IDHORAFIN)
      references HORAFECHA (IDHORAFECHA);

alter table DRAMATURGO
   add constraint FK_DRAMATUR_RELATIONS_PAIS foreign key (CODPAIS)
      references PAIS (CODPAIS);

alter table EMPLEADO
   add constraint FK_EMPLEADO_PERTENECE_UNIDAD foreign key (IDUNIDAD)
      references UNIDAD (IDUNIDAD);

alter table ESTUDIANTE
   add constraint FK_ESTUDIAN_RELATIONS_UNIDAD foreign key (IDUNIDAD)
      references UNIDAD (IDUNIDAD);

alter table GASTOOBRA
   add constraint FK_GASTOOBR_RELATIONS_OBRA foreign key (IDOBRA)
      references OBRA (IDOBRA);

alter table GASTOOBRA
   add constraint FK_GASTOOBR_RELATIONS_LISTAGAS foreign key (IDLISTAGASTO, IDPERIODO)
      references LISTAGASTO (IDLISTAGASTO, IDPERIODO);

alter table LABORPERSONALOBRA
   add constraint FK_LABORPER_RELATIONS_LISTAACT foreign key (IDLISTAACTIVIDAD, IDPERIODO)
      references LISTAACTIVIDAD (IDLISTAACTIVIDAD, IDPERIODO);

alter table LABORPERSONALOBRA
   add constraint FK_LABORPER_RELATIONS_PERSONAL foreign key (IDPERSONALOBRA, IDEMPLEADO, IDUNIDAD)
      references PERSONALOBRA (IDPERSONALOBRA, IDEMPLEADO, IDUNIDAD);

alter table LABORPERSONALOBRA
   add constraint FK_LABORPER_RELATIONS_CALENDAR foreign key (IDCALENDARIO, IDOBRA)
      references CALENDARIO (IDCALENDARIO, IDOBRA);

alter table LISTAACTIVIDAD
   add constraint FK_LISTAACT_RELATIONS_PERIODO foreign key (IDPERIODO)
      references PERIODO (IDPERIODO);

alter table LISTAGASTO
   add constraint FK_LISTAGAS_RELATIONS_PERIODO foreign key (IDPERIODO)
      references PERIODO (IDPERIODO);

alter table OBRA
   add constraint FK_OBRA_FUE_CREAD_PAIS foreign key (CODPAIS)
      references PAIS (CODPAIS);

alter table OBRA
   add constraint FK_OBRA_RELATIONS_DRAMATUR foreign key (IDDRAMATURGO)
      references DRAMATURGO (IDDRAMATURGO);

alter table OBRA
   add constraint FK_OBRA_TIENE4_TIPOOBRA foreign key (IDTIPOOBRA)
      references TIPOOBRA (IDTIPOOBRA);

alter table PERSONAJE
   add constraint FK_PERSONAJ_TIENE3_OBRA foreign key (IDOBRA)
      references OBRA (IDOBRA);

alter table PERSONAJEESTUDIANTE
   add constraint FK_PERSONAJ_TIENE_ESTUDIAN foreign key (IDESTUDIANTE)
      references ESTUDIANTE (IDESTUDIANTE);

alter table PERSONAJEESTUDIANTE
   add constraint FK_PERSONAJ_UTILIZA_PERSONAJ foreign key (IDPERSONAJE, IDOBRA)
      references PERSONAJE (IDPERSONAJE, IDOBRA);

alter table PERSONALOBRA
   add constraint FK_PERSONAL_RELATIONS_EMPLEADO foreign key (IDEMPLEADO, IDUNIDAD)
      references EMPLEADO (IDEMPLEADO, IDUNIDAD);

alter table PERSONALOBRA
   add constraint FK_PERSONAL_RELATIONS_ROL foreign key (IDROL)
      references ROL (IDROL);

alter table PERSONALOBRA
   add constraint FK_PERSONAL_TIENE45_OBRA foreign key (IDOBRA)
      references OBRA (IDOBRA);

alter table UNIDAD
   add constraint FK_UNIDAD_RELATIONS_UNIDAD foreign key (UNI_IDUNIDAD)
      references UNIDAD (IDUNIDAD);

alter table UNIDAD
   add constraint FK_UNIDAD_RELATIONS_TIPOUNID foreign key (IDTIPOUNIDAD)
      references TIPOUNIDAD (IDTIPOUNIDAD);

