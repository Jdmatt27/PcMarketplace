ALTER TABLE ventas DROP CONSTRAINT fk_ventas_cliente;

ALTER TABLE ventas ADD CONSTRAINT fk_ventas_clientes
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE CASCADE;

INSERT INTO clientes VALUES (1, 'Juan Perez', 'juan@gmail.com', '600111222', 'Calle Sol 1');
INSERT INTO clientes VALUES (2, 'Ana Lopez', 'ana@gmail.com', '600222333', 'Calle Luna 2');
INSERT INTO clientes VALUES (3, 'Carlos Ruiz', 'carlos@gmail.com', '600333444', 'Calle Rio 3');
INSERT INTO clientes VALUES (4, 'Pedro Sanchez', 'pedro@gmail.com', '600444555', 'Calle Mar 4');
INSERT INTO clientes VALUES (5, 'Maria Gomez', 'maria@gmail.com', '600555666', 'Calle Norte 5');

INSERT INTO usuarios VALUES (1, 'Comercial Uno', 'comercial1@crm.com', 'COMERCIAL', 'hash123');
INSERT INTO usuarios VALUES (2, 'Comercial Dos', 'comercial2@crm.com', 'COMERCIAL', 'hash456');
INSERT INTO usuarios VALUES (3, 'Admin CRM', 'admin@crm.com', 'ADMIN', 'hash789');
INSERT INTO usuarios VALUES (4, 'Soporte CRM', 'soporte@crm.com', 'SOPORTE', 'hash101');
INSERT INTO usuarios VALUES (5, 'Gerente CRM', 'gerente@crm.com', 'GERENTE', 'hash202');

INSERT INTO productos VALUES (1, 'Portatil Lenovo', 'Portatil para oficina', 650.00, 'Informatica');
INSERT INTO productos VALUES (2, 'Monitor Samsung', 'Monitor 24 pulgadas', 150.00, 'Informatica');
INSERT INTO productos VALUES (3, 'Teclado Logitech', 'Teclado mecanico', 80.00, 'Perifericos');
INSERT INTO productos VALUES (4, 'Raton HP', 'Raton inalambrico', 25.00, 'Perifericos');
INSERT INTO productos VALUES (5, 'Impresora Epson', 'Impresora multifuncion', 200.00, 'Oficina');

INSERT INTO ventas VALUES (1, 1, 1, DATE '2024-01-10', 'PENDIENTE', 650.00);
INSERT INTO ventas VALUES (2, 2, 2, DATE '2024-01-15', 'PAGADA', 150.00);
INSERT INTO ventas VALUES (3, 3, 1, DATE '2024-02-05', 'PAGADA', 80.00);
INSERT INTO ventas VALUES (4, 4, 3, DATE '2024-02-20', 'CANCELADA', 25.00);
INSERT INTO ventas VALUES (5, 5, 4, DATE '2024-03-01', 'PENDIENTE', 200.00);

INSERT INTO detalle_venta VALUES (1, 1, 1, 1, 650.00);
INSERT INTO detalle_venta VALUES (2, 2, 2, 1, 150.00);
INSERT INTO detalle_venta VALUES (3, 3, 3, 1, 80.00);
INSERT INTO detalle_venta VALUES (4, 4, 4, 1, 25.00);
INSERT INTO detalle_venta VALUES (5, 5, 5, 1, 200.00);

COMMIT;

UPDATE clientes SET telefono = '611111111' WHERE id_cliente = 1;
UPDATE clientes SET telefono = '622222222' WHERE id_cliente = 2;
UPDATE clientes SET direccion = 'Nueva Calle 3' WHERE id_cliente = 3;
UPDATE clientes SET direccion = 'Nueva Calle 4' WHERE id_cliente = 4;
UPDATE clientes SET nombre = 'Maria Gomez M' WHERE id_cliente = 5;

UPDATE usuarios SET rol = 'ADMIN' WHERE id_usuario = 1;
UPDATE usuarios SET rol = 'COMERCIAL SENIOR' WHERE id_usuario = 2;
UPDATE usuarios SET nombre = 'Administrador CRM' WHERE id_usuario = 3;
UPDATE usuarios SET rol = 'TECNICO' WHERE id_usuario = 4;
UPDATE usuarios SET email = 'gerente.m@crm.com' WHERE id_usuario = 5;

UPDATE productos SET precio = 700.00 WHERE id_producto = 1;
UPDATE productos SET precio = 175.00 WHERE id_producto = 2;
UPDATE productos SET categoria = 'Gaming' WHERE id_producto = 3;
UPDATE productos SET descripcion = 'Raton optico inalambrico' WHERE id_producto = 4;
UPDATE productos SET precio = 230.00 WHERE id_producto = 5;

UPDATE ventas SET estado = 'PAGADA' WHERE id_venta = 1;
UPDATE ventas SET total = 175.00 WHERE id_venta = 2;
UPDATE ventas SET estado = 'ENTREGADA' WHERE id_venta = 3;
UPDATE ventas SET estado = 'REVISADA' WHERE id_venta = 4;
UPDATE ventas SET total = 230.00 WHERE id_venta = 5;

UPDATE detalle_venta SET precio_unitario = 700.00 WHERE id_detalle = 1;
UPDATE detalle_venta SET precio_unitario = 175.00 WHERE id_detalle = 2;
UPDATE detalle_venta SET cantidad = 2 WHERE id_detalle = 3;
UPDATE detalle_venta SET cantidad = 3 WHERE id_detalle = 4;
UPDATE detalle_venta SET precio_unitario = 230.00 WHERE id_detalle = 5;

COMMIT;

DELETE FROM detalle_venta WHERE id_detalle = 5;
DELETE FROM ventas WHERE id_venta = 5;
DELETE FROM productos WHERE id_producto = 5;
DELETE FROM usuarios WHERE id_usuario = 5;
DELETE FROM clientes WHERE id_cliente = 5;

COMMIT;