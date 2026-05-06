DROP DATABASE IF EXISTS crm;
CREATE DATABASE crm;
USE crm;

CREATE TABLE clientes (
                          id_cliente INT AUTO_INCREMENT PRIMARY KEY,
                          nombre VARCHAR(100) NOT NULL,
                          email VARCHAR(100) NOT NULL,
                          telefono VARCHAR(20),
                          direccion VARCHAR(150)
);

CREATE TABLE usuarios (
                          id_usuario INT AUTO_INCREMENT PRIMARY KEY,
                          nombre VARCHAR(100) NOT NULL,
                          email VARCHAR(100) NOT NULL UNIQUE,
                          rol VARCHAR(50) NOT NULL,
                          password_hash VARCHAR(255) NOT NULL
);

CREATE TABLE productos (
                           id_producto INT AUTO_INCREMENT PRIMARY KEY,
                           nombre VARCHAR(100) NOT NULL,
                           descripcion TEXT,
                           precio DECIMAL(10,2) NOT NULL,
                           categoria VARCHAR(50)
);

CREATE TABLE ventas (
                        id_venta INT AUTO_INCREMENT PRIMARY KEY,
                        id_cliente INT,
                        id_usuario INT,
                        fecha DATE NOT NULL,
                        estado VARCHAR(50) NOT NULL,
                        total DECIMAL(10,2) NOT NULL,
                        FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
                        FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE detalle_venta (
                               id_detalle INT AUTO_INCREMENT PRIMARY KEY,
                               id_venta INT,
                               id_producto INT,
                               cantidad INT NOT NULL,
                               precio_unitario DECIMAL(10,2) NOT NULL,
                               FOREIGN KEY (id_venta) REFERENCES ventas(id_venta) ON DELETE CASCADE,
                               FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);