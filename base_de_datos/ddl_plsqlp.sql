BEGIN
    FOR t IN (
        SELECT table_name FROM user_tables
        WHERE table_name IN (
            'DETALLE_VENTA','VENTAS','PRODUCTOS','USUARIOS','CLIENTES'
        )
    ) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || t.table_name || ' CASCADE CONSTRAINTS';
    END LOOP;
END;
/

BEGIN
    FOR s IN (
        SELECT sequence_name FROM user_sequences
        WHERE sequence_name IN (
            'SEQ_CLIENTES','SEQ_USUARIOS','SEQ_PRODUCTOS',
            'SEQ_VENTAS','SEQ_DETALLE_VENTA'
        )
    ) LOOP
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || s.sequence_name;
    END LOOP;
END;
/

CREATE SEQUENCE seq_clientes START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_usuarios START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_productos START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_ventas START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_detalle_venta START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE TABLE clientes (
    id_cliente NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) NOT NULL,
    telefono VARCHAR2(20),
    direccion VARCHAR2(150)
);

CREATE TABLE usuarios (
    id_usuario NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) NOT NULL,
    rol VARCHAR2(50) NOT NULL,
    password_hash VARCHAR2(255) NOT NULL,
    CONSTRAINT uq_usuarios_email UNIQUE (email)
);

CREATE TABLE productos (
    id_producto NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    descripcion CLOB,
    precio NUMBER(10,2) NOT NULL,
    categoria VARCHAR2(50)
);

CREATE TABLE ventas (
    id_venta NUMBER PRIMARY KEY,
    id_cliente NUMBER,
    id_usuario NUMBER,
    fecha DATE NOT NULL,
    estado VARCHAR2(50) NOT NULL,
    total NUMBER(10,2) NOT NULL,
    CONSTRAINT fk_ventas_cliente  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT fk_ventas_usuario  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE detalle_venta (
    id_detalle NUMBER PRIMARY KEY,
    id_venta NUMBER,
    id_producto NUMBER,
    cantidad NUMBER NOT NULL,
    precio_unitario NUMBER(10,2) NOT NULL,
    CONSTRAINT fk_detalle_venta FOREIGN KEY (id_venta) REFERENCES ventas(id_venta) ON DELETE CASCADE,
    CONSTRAINT fk_detalle_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE OR REPLACE TRIGGER trg_clientes_bi
    BEFORE INSERT ON clientes
    FOR EACH ROW
BEGIN
    IF :NEW.id_cliente IS NULL THEN
        :NEW.id_cliente := seq_clientes.NEXTVAL;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_usuarios_bi
    BEFORE INSERT ON usuarios
    FOR EACH ROW
BEGIN
    IF :NEW.id_usuario IS NULL THEN
        :NEW.id_usuario := seq_usuarios.NEXTVAL;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_productos_bi
    BEFORE INSERT ON productos
    FOR EACH ROW
BEGIN
    IF :NEW.id_producto IS NULL THEN
        :NEW.id_producto := seq_productos.NEXTVAL;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_ventas_bi
    BEFORE INSERT ON ventas
    FOR EACH ROW
BEGIN
    IF :NEW.id_venta IS NULL THEN
        :NEW.id_venta := seq_ventas.NEXTVAL;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_detalle_venta_bi
    BEFORE INSERT ON detalle_venta
    FOR EACH ROW
BEGIN
    IF :NEW.id_detalle IS NULL THEN
        :NEW.id_detalle := seq_detalle_venta.NEXTVAL;
    END IF;
END;
/