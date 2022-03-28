-- Generado por Oracle SQL Developer Data Modeler 21.4.1.349.1605
--   en:        2022-03-01 17:35:48 CST
--   sitio:      Oracle Database 21c
--   tipo:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE cede (
    id_cede            INTEGER NOT NULL,
    fecha              DATE,
    cliente_dni        INTEGER NOT NULL,
    vehiculo_matricula INTEGER NOT NULL
);

ALTER TABLE cede ADD CONSTRAINT cede_pk PRIMARY KEY ( id_cede );

CREATE TABLE cliente (
    dni       INTEGER NOT NULL,
    nombre    VARCHAR2(50 CHAR),
    direccion VARCHAR2(70 CHAR),
    telefono  INTEGER
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( dni );

CREATE TABLE compra (
    matricula        VARCHAR2(20 CHAR) NOT NULL,
    fecha            DATE,
    cliente_dni      INTEGER NOT NULL,
    modelo_id_modelo INTEGER NOT NULL
);

ALTER TABLE compra ADD CONSTRAINT compra_pk PRIMARY KEY ( matricula );

CREATE TABLE modelo (
    id_modelo  INTEGER NOT NULL,
    marca      VARCHAR2(50 CHAR),
    cilindrada INTEGER,
    modelo     VARCHAR2(50 CHAR),
    precio     INTEGER
);

ALTER TABLE modelo ADD CONSTRAINT modelo_pk PRIMARY KEY ( id_modelo );

CREATE TABLE opcion (
    id_opcion        INTEGER,
    nombre           VARCHAR2(50 CHAR),
    descripcion      VARCHAR2(150 CHAR),
    compra_matricula VARCHAR2(20 CHAR) NOT NULL
);

CREATE TABLE vehiculo (
    matricula INTEGER NOT NULL,
    marca     VARCHAR2(50 CHAR),
    modelo    VARCHAR2(50 CHAR),
    precio    INTEGER
);

ALTER TABLE vehiculo ADD CONSTRAINT vehiculo_pk PRIMARY KEY ( matricula );

CREATE TABLE vendedor (
    dni              INTEGER NOT NULL,
    direccion        VARCHAR2(150 CHAR),
    nombre           VARCHAR2(50 CHAR),
    telefono         INTEGER,
    compra_matricula VARCHAR2(20 CHAR) NOT NULL
);

ALTER TABLE vendedor ADD CONSTRAINT vendedor_pk PRIMARY KEY ( dni );

ALTER TABLE cede
    ADD CONSTRAINT cede_cliente_fk FOREIGN KEY ( cliente_dni )
        REFERENCES cliente ( dni );

ALTER TABLE cede
    ADD CONSTRAINT cede_vehiculo_fk FOREIGN KEY ( vehiculo_matricula )
        REFERENCES vehiculo ( matricula );

ALTER TABLE compra
    ADD CONSTRAINT compra_cliente_fk FOREIGN KEY ( cliente_dni )
        REFERENCES cliente ( dni );

ALTER TABLE compra
    ADD CONSTRAINT compra_modelo_fk FOREIGN KEY ( modelo_id_modelo )
        REFERENCES modelo ( id_modelo );

ALTER TABLE opcion
    ADD CONSTRAINT opcion_compra_fk FOREIGN KEY ( compra_matricula )
        REFERENCES compra ( matricula );

ALTER TABLE vendedor
    ADD CONSTRAINT vendedor_compra_fk FOREIGN KEY ( compra_matricula )
        REFERENCES compra ( matricula );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             7
-- CREATE INDEX                             0
-- ALTER TABLE                             12
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
