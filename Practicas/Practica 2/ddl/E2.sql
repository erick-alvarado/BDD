-- Generated by Oracle SQL Developer Data Modeler 21.4.1.349.1605
--   at:        2022-02-24 11:49:25 CST
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE categoria (
    id_categoria INTEGER NOT NULL,
    nombre       VARCHAR2(50),
    descripcion  VARCHAR2(100)
);

ALTER TABLE categoria ADD CONSTRAINT categoria_pk PRIMARY KEY ( id_categoria );

CREATE TABLE cliente (
    id_cliente             INTEGER NOT NULL,
    rut                    INTEGER,
    nombre                 VARCHAR2(30 CHAR),
    url_web                VARCHAR2(80 CHAR),
    direccion_id_direccion INTEGER NOT NULL
);

CREATE UNIQUE INDEX cliente__idx ON
    cliente (
        direccion_id_direccion
    ASC );

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( id_cliente );

CREATE TABLE contacto (
    id_contacto        INTEGER NOT NULL,
    numero             INTEGER,
    cliente_id_cliente INTEGER NOT NULL
);

ALTER TABLE contacto ADD CONSTRAINT contacto_pk PRIMARY KEY ( id_contacto );

CREATE TABLE direccion (
    id_direccion INTEGER NOT NULL,
    calle        VARCHAR2(30 CHAR),
    numero       SMALLINT,
    comuna       VARCHAR2(30 CHAR),
    ciudad       VARCHAR2(30 CHAR)
);

ALTER TABLE direccion ADD CONSTRAINT direccion_pk PRIMARY KEY ( id_direccion );

CREATE TABLE factura (
    id_factura         INTEGER NOT NULL,
    fecha              DATE,
    descuento          NUMBER,
    total              NUMBER,
    cliente_id_cliente INTEGER NOT NULL
);

ALTER TABLE factura ADD CONSTRAINT factura_pk PRIMARY KEY ( id_factura );

CREATE TABLE producto (
    id_producto            INTEGER NOT NULL,
    nombre                 VARCHAR2(50),
    precio                 NUMBER,
    stock                  INTEGER,
    categoria_id_categoria INTEGER NOT NULL
);

ALTER TABLE producto ADD CONSTRAINT producto_pk PRIMARY KEY ( id_producto );

CREATE TABLE proveedor (
    id_proveedor           INTEGER NOT NULL,
    rut                    INTEGER,
    nombre                 VARCHAR2(30 CHAR),
    telefono               INTEGER,
    url_web                VARCHAR2(80 CHAR),
    direccion_id_direccion INTEGER NOT NULL
);

CREATE UNIQUE INDEX proveedor__idx ON
    proveedor (
        direccion_id_direccion
    ASC );

ALTER TABLE proveedor ADD CONSTRAINT proveedor_pk PRIMARY KEY ( id_proveedor );

CREATE TABLE venta (
    id_venta             INTEGER NOT NULL,
    precio               NUMBER,
    cantidad             INTEGER,
    total                NUMBER,
    factura_id_factura   INTEGER NOT NULL,
    producto_id_producto INTEGER NOT NULL
);

ALTER TABLE venta ADD CONSTRAINT venta_pk PRIMARY KEY ( id_venta );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_direccion_fk FOREIGN KEY ( direccion_id_direccion )
        REFERENCES direccion ( id_direccion );

ALTER TABLE contacto
    ADD CONSTRAINT contacto_cliente_fk FOREIGN KEY ( cliente_id_cliente )
        REFERENCES cliente ( id_cliente );

ALTER TABLE factura
    ADD CONSTRAINT factura_cliente_fk FOREIGN KEY ( cliente_id_cliente )
        REFERENCES cliente ( id_cliente );

ALTER TABLE producto
    ADD CONSTRAINT producto_categoria_fk FOREIGN KEY ( categoria_id_categoria )
        REFERENCES categoria ( id_categoria );

ALTER TABLE proveedor
    ADD CONSTRAINT proveedor_direccion_fk FOREIGN KEY ( direccion_id_direccion )
        REFERENCES direccion ( id_direccion );

ALTER TABLE venta
    ADD CONSTRAINT venta_factura_fk FOREIGN KEY ( factura_id_factura )
        REFERENCES factura ( id_factura );

ALTER TABLE venta
    ADD CONSTRAINT venta_producto_fk FOREIGN KEY ( producto_id_producto )
        REFERENCES producto ( id_producto );



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             8
-- CREATE INDEX                             2
-- ALTER TABLE                             15
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
