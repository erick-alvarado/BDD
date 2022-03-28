-- Generado por Oracle SQL Developer Data Modeler 21.4.1.349.1605
--   en:        2022-03-02 20:07:49 CST
--   sitio:      Oracle Database 21c
--   tipo:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE envio (
    id_envio             INTEGER NOT NULL,
    kilometros           INTEGER,
    coste                INTEGER,
    destino              VARCHAR2(80 CHAR),
    fecha_llegada        DATE,
    transportista_id_emp INTEGER NOT NULL,
    traslado_id_traslado INTEGER NOT NULL
);

ALTER TABLE envio ADD CONSTRAINT envio_pk PRIMARY KEY ( id_envio );

CREATE TABLE producto_residuo (
    id_pr                  INTEGER NOT NULL,
    envase                 VARCHAR2(50 CHAR),
    productor_id_productor INTEGER NOT NULL,
    residuo_id_residuo     INTEGER NOT NULL
);

ALTER TABLE producto_residuo ADD CONSTRAINT producto_residuo_pk PRIMARY KEY ( id_pr );

CREATE TABLE productor (
    id_productor INTEGER NOT NULL
);

ALTER TABLE productor ADD CONSTRAINT productor_pk PRIMARY KEY ( id_productor );

CREATE TABLE residuo (
    id_residuo     INTEGER NOT NULL,
    constituyentes VARCHAR2(50 CHAR),
    cantidad_const INTEGER
);

ALTER TABLE residuo ADD CONSTRAINT residuo_pk PRIMARY KEY ( id_residuo );

CREATE TABLE tipo_trans (
    id_tipo INTEGER NOT NULL,
    tipo    VARCHAR2(80 CHAR)
);

ALTER TABLE tipo_trans ADD CONSTRAINT tipo_transporte_pk PRIMARY KEY ( id_tipo );

CREATE TABLE transportista (
    id_emp             INTEGER NOT NULL,
    nombre             VARCHAR2(50 CHAR),
    tipo_trans_id_tipo INTEGER NOT NULL
);

ALTER TABLE transportista ADD CONSTRAINT empresa_transporte_pk PRIMARY KEY ( id_emp );

CREATE TABLE traslado (
    id_traslado            INTEGER NOT NULL,
    destino                VARCHAR2(90 CHAR),
    producto_residuo_id_pr INTEGER NOT NULL,
    cantidad               INTEGER
);

ALTER TABLE traslado ADD CONSTRAINT traslado_pk PRIMARY KEY ( id_traslado );

CREATE TABLE tratamiento (
    id_tr          INTEGER NOT NULL,
    tipo           VARCHAR2(120 CHAR),
    envio_id_envio INTEGER NOT NULL
);

ALTER TABLE tratamiento ADD CONSTRAINT tratamiento_pk PRIMARY KEY ( id_tr );

ALTER TABLE envio
    ADD CONSTRAINT envio_transportista_fk FOREIGN KEY ( transportista_id_emp )
        REFERENCES transportista ( id_emp );

ALTER TABLE envio
    ADD CONSTRAINT envio_traslado_fk FOREIGN KEY ( traslado_id_traslado )
        REFERENCES traslado ( id_traslado );

ALTER TABLE producto_residuo
    ADD CONSTRAINT producto_residuo_productor_fk FOREIGN KEY ( productor_id_productor )
        REFERENCES productor ( id_productor );

ALTER TABLE producto_residuo
    ADD CONSTRAINT producto_residuo_residuo_fk FOREIGN KEY ( residuo_id_residuo )
        REFERENCES residuo ( id_residuo );

ALTER TABLE transportista
    ADD CONSTRAINT transportista_tipo_trans_fk FOREIGN KEY ( tipo_trans_id_tipo )
        REFERENCES tipo_trans ( id_tipo );

ALTER TABLE traslado
    ADD CONSTRAINT traslado_producto_residuo_fk FOREIGN KEY ( producto_residuo_id_pr )
        REFERENCES producto_residuo ( id_pr );

ALTER TABLE tratamiento
    ADD CONSTRAINT tratamiento_envio_fk FOREIGN KEY ( envio_id_envio )
        REFERENCES envio ( id_envio );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             8
-- CREATE INDEX                             0
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
