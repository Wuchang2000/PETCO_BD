/*
 * ER/Studio 8.0 SQL Code Generation
 * Company :      FI-UNAM
 * Project :      P1.DM1
 * Author :       Leon_M119
 *
 * Date Created : Tuesday, June 06, 2023 15:32:46
 * Target DBMS : Microsoft SQL Server 2008
 */

/* 
 * TABLE: ADMINISTRATIVO 
 */
drop database Equipo7_PETCO

create database Equipo7_PETCO

use Equipo7_PETCO

CREATE TABLE ADMINISTRATIVO(
    id_empleado    numeric(10, 0)    NOT NULL,
    id_estado      numeric(10, 0)    NOT NULL,
    CONSTRAINT PK_ADMINISTRATIVO PRIMARY KEY NONCLUSTERED (id_empleado)
)
go



IF OBJECT_ID('ADMINISTRATIVO') IS NOT NULL
    PRINT '<<< CREATED TABLE ADMINISTRATIVO >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ADMINISTRATIVO >>>'
go

/*
 * TABLE: Categoria_producto
 */

CREATE TABLE CATEGORIA_PRODUCTO(
	id_categoria	numeric(2,0) IDENTITY(1,1),
	descripcion		varchar(40)
	Constraint PK_CATEGORIA_PRODUCTO Primary key NONCLUSTERED (id_categoria)
)

IF OBJECT_ID('CATEGORIA_PRODUCTO') IS NOT NULL
    PRINT '<<< CREATED TABLE CATEGORIA_PRODUCTO >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CATEGORIA_PRODUCTO >>>'
go

/* 
 * TABLE: CAR_PROD 
 */

CREATE TABLE CAR_PROD(
    id_producto     numeric(10, 0)    NOT NULL,
    id_carrito      numeric(10, 0)    NOT NULL,
    montoParcial    money             NOT NULL,
    cantidad        numeric(10, 0)    NOT NULL,
    CONSTRAINT PK_CAR_PROD PRIMARY KEY NONCLUSTERED (id_producto, id_carrito)
)
go



IF OBJECT_ID('CAR_PROD') IS NOT NULL
    PRINT '<<< CREATED TABLE CAR_PROD >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CAR_PROD >>>'
go

/* 
 * TABLE: CARRITO 
 */

CREATE TABLE CARRITO(
    id_carrito    numeric(10, 0)    NOT NULL,
    id_usuario    numeric(10, 0)    NOT NULL,
    cantidad      numeric(10, 0)    NOT NULL,
    CONSTRAINT PK_CARRITO PRIMARY KEY NONCLUSTERED (id_carrito)
)
go



IF OBJECT_ID('CARRITO') IS NOT NULL
    PRINT '<<< CREATED TABLE CARRITO >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CARRITO >>>'
go

/* 
 * TABLE: CENTRO 
 */

CREATE TABLE CENTRO(
    id_centro           numeric(10, 0)    IDENTITY(1,1),
    id_estado           numeric(10, 0)    NOT NULL,
    oficina_regional    numeric(1, 0)     NOT NULL
                        CONSTRAINT CK_CS6 CHECK (oficina_regional in (0,1) ),
    CONSTRAINT PK_CENTRO PRIMARY KEY NONCLUSTERED (id_centro)
)
go



IF OBJECT_ID('CENTRO') IS NOT NULL
    PRINT '<<< CREATED TABLE CENTRO >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CENTRO >>>'
go

/* 
 * TABLE: COMPRA_CARRITO 
 */

CREATE TABLE COMPRA_CARRITO(
    id_ventaC       numeric(10, 0)    IDENTITY(1,1) NOT NULL,
    id_producto     numeric(10, 0)    NOT NULL,
    id_carrito      numeric(10, 0)    NOT NULL,
    id_usuario      numeric(10, 0)    NOT NULL,
    detalles        varchar(40)       NOT NULL,
    montoParcial    money             NOT NULL,
    CONSTRAINT PK_COMPRA_CARRITO PRIMARY KEY NONCLUSTERED (id_ventaC)
)
go



IF OBJECT_ID('COMPRA_CARRITO') IS NOT NULL
    PRINT '<<< CREATED TABLE COMPRA_CARRITO >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE COMPRA_CARRITO >>>'
go

/* 
 * TABLE: CONSULTA 
 */

CREATE TABLE CONSULTA(
    id_consulta    numeric(10, 0)    IDENTITY(1,1) NOT NULL,
    id_empleado    numeric(10, 0)    NOT NULL,
    fecha          date              NOT NULL,
    hora           time(7)           NOT NULL,
    diagnostico    varchar(40)       NOT NULL,
    detalles       varchar(40)       NOT NULL,
    costo_total    money             NOT NULL,
    id_mascota     numeric(10, 0)    NOT NULL,
    CONSTRAINT PK_CONSULTA PRIMARY KEY NONCLUSTERED (id_consulta)
)
go



IF OBJECT_ID('CONSULTA') IS NOT NULL
    PRINT '<<< CREATED TABLE CONSULTA >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CONSULTA >>>'
go

/* 
 * TABLE: DETALLE_CUENTA 
 */

CREATE TABLE DETALLE_CUENTA(
    id_ventaF       numeric(10, 0)    NOT NULL,
    id_producto     numeric(10, 0)    NOT NULL,
    montoParcial    money             NOT NULL,
    cantidad        numeric(10, 0)    NOT NULL,
    CONSTRAINT PK_DETALLE_CUENTA PRIMARY KEY NONCLUSTERED (id_ventaF, id_producto)
)
go



IF OBJECT_ID('DETALLE_CUENTA') IS NOT NULL
    PRINT '<<< CREATED TABLE DETALLE_CUENTA >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DETALLE_CUENTA >>>'
go

/* 
 * TABLE: EMPLEADO 
 */

CREATE TABLE EMPLEADO(
    id_empleado    numeric(10, 0)    IDENTITY(1,1),
    id_centro      numeric(10, 0)    NOT NULL,
    nombre         varchar(20)       NOT NULL,
	paterno        varchar(15)       NOT NULL,
    materno        varchar(15)       NOT NULL,
    CURP           varchar(18)       NOT NULL,
    domicilio      varchar(40)       NOT NULL,
    CONSTRAINT PK_EMPLEADO PRIMARY KEY NONCLUSTERED (id_empleado),
	CONSTRAINT UQ_curpE unique (curp)
)
go



IF OBJECT_ID('EMPLEADO') IS NOT NULL
    PRINT '<<< CREATED TABLE EMPLEADO >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE EMPLEADO >>>'
go

/* 
 * TABLE: ESTADO 
 */

CREATE TABLE ESTADO(
    id_estado    numeric(10, 0)    IDENTITY(1,1),
    nombre       varchar(40)       NOT NULL,
    CONSTRAINT PK_ESTADO PRIMARY KEY NONCLUSTERED (id_estado)
)
go



IF OBJECT_ID('ESTADO') IS NOT NULL
    PRINT '<<< CREATED TABLE ESTADO >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ESTADO >>>'
go

/* 
 * TABLE: GUARDERIA 
 */

CREATE TABLE GUARDERIA(
    id_guarderia    numeric(10, 0)    IDENTITY(1,1),
    fecha_ini       datetime          NOT NULL,
    fecha_fin       datetime          NOT NULL,
    costo			as datediff(day,fecha_ini,fecha_fin)*300,
    id_centro       numeric(10, 0)    NOT NULL,
    CONSTRAINT PK_GUARDERIA PRIMARY KEY NONCLUSTERED (id_guarderia)
)
go

IF OBJECT_ID('GUARDERIA') IS NOT NULL
    PRINT '<<< CREATED TABLE GUARDERIA >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE GUARDERIA >>>'
go

/* 
 * TABLE: MASCOTA 
 */

CREATE TABLE MASCOTA(
    id_mascota      numeric(10, 0)    IDENTITY(1,1),
    id_empleado     numeric(10, 0)    NOT NULL,
    id_usuario      numeric(10, 0)    NOT NULL,
    id_guarderia    numeric(10, 0)    NOT NULL,
    nombre          varchar(10)       NOT NULL,
    especie         varchar(10)       NOT NULL,
    sexo            varchar(10)       NOT NULL,
    raza            varchar(10)       NOT NULL,
    razgos          varchar(40)       NOT NULL,
    edad            numeric(2, 0)     NOT NULL,
    CONSTRAINT PK_MASCOTA PRIMARY KEY NONCLUSTERED (id_mascota)
)
go



IF OBJECT_ID('MASCOTA') IS NOT NULL
    PRINT '<<< CREATED TABLE MASCOTA >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE MASCOTA >>>'
go

/* 
 * TABLE: MEDICAMENTO 
 */

CREATE TABLE MEDICAMENTO(
    id_medicamento        numeric(10, 0)    IDENTITY(1,1),
    id_consulta           numeric(10, 0)    NOT NULL,
    nombre_medicamento    varchar(10)       NOT NULL,
    costo                 money             NOT NULL,
	cantidad			  numeric(4, 0)		NOT NULL
    CONSTRAINT PK_MEDICAMENTO PRIMARY KEY NONCLUSTERED (id_medicamento)
)
go



IF OBJECT_ID('MEDICAMENTO') IS NOT NULL
    PRINT '<<< CREATED TABLE MEDICAMENTO >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE MEDICAMENTO >>>'
go

/* 
 * TABLE: OFERTA 
 */

CREATE TABLE OFERTA(
    id_oferta      numeric(10, 0)    IDENTITY(1,1),
    tipo           char(1)           NOT NULL
                   CONSTRAINT CK_CS2 CHECK (tipo in('N','L') ),
    porcentaje	   decimal(5,2)      NOT NULL,
    fecha_ini      datetime          NOT NULL,
    fecha_fin      datetime          NOT NULL,
    CONSTRAINT PK_OFERTA PRIMARY KEY NONCLUSTERED (id_oferta),
	CONSTRAINT CK_CS3 CHECK (datediff(day,fecha_ini,fecha_fin) <40)
)
go

IF OBJECT_ID('OFERTA') IS NOT NULL
    PRINT '<<< CREATED TABLE OFERTA >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE OFERTA >>>'
go

/* 
 * TABLE: PERSONAL_AYUDA 
 */

CREATE TABLE PERSONAL_AYUDA(
    id_empleado    numeric(10, 0)    NOT NULL,
    usuario        varchar(10)       NOT NULL,
    contraseña     varchar(20)       NOT NULL,
    edad           numeric(2, 0)     NOT NULL,
    mascota        char(1)           NOT NULL
                   CONSTRAINT CK_CS1 CHECK (mascota in('P','G') ),
    CONSTRAINT PK_PERSONAL_AYUDA PRIMARY KEY NONCLUSTERED (id_empleado),
	CONSTRAINT UQ_USUARIO unique (usuario)
)
go



IF OBJECT_ID('PERSONAL_AYUDA') IS NOT NULL
    PRINT '<<< CREATED TABLE PERSONAL_AYUDA >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE PERSONAL_AYUDA >>>'
go

/* 
 * TABLE: PRODUCTO_CENTRAL 
 */

CREATE TABLE PRODUCTO_CENTRAL(
    id_producto    numeric(10, 0)    NOT NULL,
	id_categoria   numeric(2,0)		 NOT NULL,
    id_oferta      numeric(10, 0)    NULL,
    detalles       varchar(40)       NOT NULL,
    precio         money             NOT NULL,
    CONSTRAINT PK_PRODUCTO_CENTRAL PRIMARY KEY NONCLUSTERED (id_producto)
)
go



IF OBJECT_ID('PRODUCTO_CENTRAL') IS NOT NULL
    PRINT '<<< CREATED TABLE PRODUCTO_CENTRAL >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE PRODUCTO_CENTRAL >>>'
go



/* 
 * TABLE: PRODUCTO_TIENDA 
 */

CREATE TABLE PRODUCTO_TIENDA(
    id_producto    numeric(10, 0)    NOT NULL,
	id_categoria   numeric(2,0)	 NOT NULL,
    id_oferta      numeric(10, 0)    NULL,
    detalles       varchar(40)       NOT NULL,
    precio         money             NOT NULL,
    CONSTRAINT PK_PRODUCTO_TIENDA PRIMARY KEY NONCLUSTERED (id_producto)
)
go



IF OBJECT_ID('PRODUCTO_TIENDA') IS NOT NULL
    PRINT '<<< CREATED TABLE PRODUCTO_TIENDA >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE PRODUCTO_TIENDA >>>'
go

/* 
 * TABLE: REGISTRO_BRAZALETE 
 */

CREATE TABLE REGISTRO_BRAZALETE(
    id_registro     numeric(10, 0)    IDENTITY(1,1),
    id_mascota      numeric(10, 0)    NOT NULL,
    ritmoC          char(10)          NOT NULL,
    [fecha/hora]    datetime          NOT NULL,
    temp            varchar(10)       NOT NULL,
    nivelOx         varchar(10)       NOT NULL,
    tipo_Comida     varchar(10)       NOT NULL,
    comida_Comio    varchar(10)       NOT NULL,
    CONSTRAINT PK_REGISTRO_BRAZALETE PRIMARY KEY NONCLUSTERED (id_registro)
)
go



IF OBJECT_ID('REGISTRO_BRAZALETE') IS NOT NULL
    PRINT '<<< CREATED TABLE REGISTRO_BRAZALETE >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE REGISTRO_BRAZALETE >>>'
go

/* 
 * TABLE: TELEFONO_PERSONAL 
 */

CREATE TABLE TELEFONO_PERSONAL(
    id_telefono    numeric(1, 0)     NOT NULL,
    id_empleado    numeric(10, 0)    NOT NULL,
    telefono       numeric(10, 0)    NOT NULL,
    CONSTRAINT PK_TELEFONO_PERSONAL PRIMARY KEY NONCLUSTERED (id_telefono)
)
go



IF OBJECT_ID('TELEFONO_PERSONAL') IS NOT NULL
    PRINT '<<< CREATED TABLE TELEFONO_PERSONAL >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE TELEFONO_PERSONAL >>>'
go

/* 
 * TABLE: USUARIO_COMUN 
 */

CREATE TABLE USUARIO_COMUN(
    id_usuario    numeric(10, 0)    IDENTITY(1,1),
    nom           varchar(10)       NOT NULL,
    pat           varchar(10)       NOT NULL,
    mat           varchar(10)       NOT NULL,
    domicilio     varchar(40)       NOT NULL,
    CURP          varchar(18)       NOT NULL,
    genero        char(1)           NOT NULL
	CONSTRAINT CK_CS7 CHECK (genero in('H','M') ),
    telefono      numeric(10, 0)    NOT NULL,
    numTargeta    numeric(19, 0)    NOT NULL,
    vigencia      date              NOT NULL,
    correo        varchar(50)       NOT NULL ,
    contraseña    varchar(20)       NOT NULL,
    CONSTRAINT PK_USUARIO_COMUN PRIMARY KEY NONCLUSTERED (id_usuario),
	CONSTRAINT UQ_curpU unique (curp),
	CONSTRAINT UQ_correoU unique (correo),
	CONSTRAINT UQ_tele unique (telefono),
	CONSTRAINT UQ_numT unique (numTargeta)
)
go



IF OBJECT_ID('USUARIO_COMUN') IS NOT NULL
    PRINT '<<< CREATED TABLE USUARIO_COMUN >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE USUARIO_COMUN >>>'
go

/* 
 * TABLE: VENDEDOR 
 */

CREATE TABLE VENDEDOR(
    id_empleado     numeric(10, 0)    NOT NULL,
    sueldo          money             NOT NULL,
    sueldo_total    money             NOT NULL,
    comision        money             NOT NULL,
    CONSTRAINT PK_VENDEDOR PRIMARY KEY NONCLUSTERED (id_empleado)
)
go


IF OBJECT_ID('VENDEDOR') IS NOT NULL
    PRINT '<<< CREATED TABLE VENDEDOR >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE VENDEDOR >>>'
go

/* 
 * TABLE: VENTA_FISICA 
 */

CREATE TABLE VENTA_FISICA(
    id_ventaF      numeric(10, 0)    IDENTITY(1,1) NOT NULL,
    id_empleado    numeric(10, 0)    NOT NULL,
    total          money             NOT NULL,
    CONSTRAINT PK_VENTA_FISICA PRIMARY KEY NONCLUSTERED (id_ventaF)
)
go



IF OBJECT_ID('VENTA_FISICA') IS NOT NULL
    PRINT '<<< CREATED TABLE VENTA_FISICA >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE VENTA_FISICA >>>'
go

/* 
 * TABLE: VETERINARIO 
 */

CREATE TABLE VETERINARIO(
    id_empleado     numeric(10, 0)    NOT NULL,
    CEDULA          numeric(10, 0)    NOT NULL,
    especialidad    varchar(40)       NOT NULL,
    CONSTRAINT PK_VETERINARIO PRIMARY KEY NONCLUSTERED (id_empleado),
	CONSTRAINT UQ_cedula unique (CEDULA),
)
go



IF OBJECT_ID('VETERINARIO') IS NOT NULL
    PRINT '<<< CREATED TABLE VETERINARIO >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE VETERINARIO >>>'
go

/* 
 * TABLE: ADMINISTRATIVO 
 */

ALTER TABLE ADMINISTRATIVO ADD CONSTRAINT FK_ESTADO_ADMIN
    FOREIGN KEY (id_estado)
    REFERENCES ESTADO(id_estado)
go

ALTER TABLE ADMINISTRATIVO ADD CONSTRAINT FK_EMPLEADO_ADMIN
    FOREIGN KEY (id_empleado)
    REFERENCES EMPLEADO(id_empleado)
go


/* 
 * TABLE: CAR_PROD 
 */

ALTER TABLE CAR_PROD ADD CONSTRAINT FK_CARRITO_CAR_PROD
    FOREIGN KEY (id_carrito)
    REFERENCES CARRITO(id_carrito)
go

ALTER TABLE CAR_PROD ADD CONSTRAINT FK_PRODUCTO_CENTRAL_CAR_PROD
    FOREIGN KEY (id_producto)
    REFERENCES PRODUCTO_CENTRAL(id_producto)
go


/* 
 * TABLE: CARRITO 
 */

ALTER TABLE CARRITO ADD CONSTRAINT FK_USUARIO_COMUN_CARRITO
    FOREIGN KEY (id_usuario)
    REFERENCES USUARIO_COMUN(id_usuario)
go


/* 
 * TABLE: CENTRO 
 */

ALTER TABLE CENTRO ADD CONSTRAINT FK_ESTADO_CEN 
    FOREIGN KEY (id_estado)
    REFERENCES ESTADO(id_estado)
go


/* 
 * TABLE: COMPRA_CARRITO 
 */

ALTER TABLE COMPRA_CARRITO ADD CONSTRAINT FK_USUARIO_COMUN_COMPRA_CARRITO
    FOREIGN KEY (id_usuario)
    REFERENCES USUARIO_COMUN(id_usuario)
go

ALTER TABLE COMPRA_CARRITO ADD CONSTRAINT FK_CAR_PROD_COMPRA_CARRITO
    FOREIGN KEY (id_producto, id_carrito)
    REFERENCES CAR_PROD(id_producto, id_carrito)
go


/* 
 * TABLE: CONSULTA 
 */

ALTER TABLE CONSULTA ADD CONSTRAINT FK_VETERINARIO_CONSULTA
    FOREIGN KEY (id_empleado)
    REFERENCES VETERINARIO(id_empleado)
go

ALTER TABLE CONSULTA ADD CONSTRAINT FK_MASCOTA_CONSULTA
    FOREIGN KEY (id_mascota)
    REFERENCES MASCOTA(id_mascota)
go


/* 
 * TABLE: DETALLE_CUENTA 
 */

ALTER TABLE DETALLE_CUENTA ADD CONSTRAINT FK_VENTA_FISICA_DETALLE_CUENTA
    FOREIGN KEY (id_ventaF)
    REFERENCES VENTA_FISICA(id_ventaF)
go

ALTER TABLE DETALLE_CUENTA ADD CONSTRAINT FK_PRODUCTO_TIENDA_DETALLE_CUENTA
    FOREIGN KEY (id_producto)
    REFERENCES PRODUCTO_TIENDA(id_producto)
go


/* 
 * TABLE: EMPLEADO 
 */

ALTER TABLE EMPLEADO ADD CONSTRAINT FK_CENTRO_EMPLEADO 
    FOREIGN KEY (id_centro)
    REFERENCES CENTRO(id_centro)
go


/* 
 * TABLE: GUARDERIA 
 */

ALTER TABLE GUARDERIA ADD CONSTRAINT FK_CENTRO_GUARDERIA
    FOREIGN KEY (id_centro)
    REFERENCES CENTRO(id_centro)
go


/* 
 * TABLE: MASCOTA 
 */

ALTER TABLE MASCOTA ADD CONSTRAINT FK_PERSONAL_AYUDA_MASCOTA 
    FOREIGN KEY (id_empleado)
    REFERENCES PERSONAL_AYUDA(id_empleado)
go

ALTER TABLE MASCOTA ADD CONSTRAINT FK_GUARDERIA_MASCOTA
    FOREIGN KEY (id_guarderia)
    REFERENCES GUARDERIA(id_guarderia)
go

ALTER TABLE MASCOTA ADD CONSTRAINT FK_USUARIO_COMUN_MASCOTA
    FOREIGN KEY (id_usuario)
    REFERENCES USUARIO_COMUN(id_usuario)
go


/* 
 * TABLE: MEDICAMENTO 
 */

ALTER TABLE MEDICAMENTO ADD CONSTRAINT FK_CONSULTA_MEDICAMENTO
    FOREIGN KEY (id_consulta)
    REFERENCES CONSULTA(id_consulta)
go


/* 
 * TABLE: PERSONAL_AYUDA 
 */

ALTER TABLE PERSONAL_AYUDA ADD CONSTRAINT FK_EMPLEADO_PERSONAL_AYUDA
    FOREIGN KEY (id_empleado)
    REFERENCES EMPLEADO(id_empleado)
go


/* 
 * TABLE: PRODUCTO_CENTRAL 
 */

ALTER TABLE PRODUCTO_CENTRAL ADD CONSTRAINT FK_OFERTA_PRODUCTO_CENTRAL
    FOREIGN KEY (id_oferta)
    REFERENCES OFERTA(id_oferta)
go

ALTER TABLE PRODUCTO_CENTRAL ADD CONSTRAINT FK_CATEGORIA_PRODUCTO_CENTRAL
    FOREIGN KEY (id_categoria)
    REFERENCES categoria_producto(id_categoria)
go


/* 
 * TABLE: PRODUCTO_TIENDA 
 */

ALTER TABLE PRODUCTO_TIENDA ADD CONSTRAINT FK_OFERTA_PRODUCTO_TIENDA
    FOREIGN KEY (id_oferta)
    REFERENCES OFERTA(id_oferta)
go

ALTER TABLE PRODUCTO_TIENDA ADD CONSTRAINT FK_CAREGORIA_PRODUCTO_TIENDA
    FOREIGN KEY (id_categoria)
    REFERENCES categoria_producto(id_categoria)
go

/* 
 * TABLE: REGISTRO_BRAZALETE 
 */

ALTER TABLE REGISTRO_BRAZALETE ADD CONSTRAINT FK_MASCOTA_REGISTRO_BRAZALETE 
    FOREIGN KEY (id_mascota)
    REFERENCES MASCOTA(id_mascota)
go


/* 
 * TABLE: TELEFONO_PERSONAL 
 */

ALTER TABLE TELEFONO_PERSONAL ADD CONSTRAINT FK_PERSONAL_AYUDA_TELEFONO_PERSONAL 
    FOREIGN KEY (id_empleado)
    REFERENCES PERSONAL_AYUDA(id_empleado)
go


/* 
 * TABLE: VENDEDOR 
 */

ALTER TABLE VENDEDOR ADD CONSTRAINT FK_EMPLEADO_VENDEDOR 
    FOREIGN KEY (id_empleado)
    REFERENCES EMPLEADO(id_empleado)
go


/* 
 * TABLE: VENTA_FISICA 
 */

ALTER TABLE VENTA_FISICA ADD CONSTRAINT FK_VENDEDOR_VENTA_FISICA 
    FOREIGN KEY (id_empleado)
    REFERENCES VENDEDOR(id_empleado)
go

/* 
 * TABLE: VETERINARIO 
 */

ALTER TABLE VETERINARIO ADD CONSTRAINT FK_EMPLEADO_VETERINARIO
    FOREIGN KEY (id_empleado)
    REFERENCES EMPLEADO(id_empleado)