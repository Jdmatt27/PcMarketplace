-- ============================================================
--  PROYECTO CRM - 2 PROCEDIMIENTOS + 2 FUNCIONES POR TABLA
-- ============================================================


-- ============================================================
--  TABLA: CLIENTES
-- ============================================================

-- PROCEDIMIENTO 1: Listar todos los clientes
CREATE OR REPLACE PROCEDURE proc_listar_clientes IS
    CURSOR c_clientes IS
        SELECT id_cliente, nombre, email, telefono
        FROM clientes
        ORDER BY nombre ASC;

    v_id       clientes.id_cliente%TYPE;
    v_nombre   clientes.nombre%TYPE;
    v_email    clientes.email%TYPE;
    v_telefono clientes.telefono%TYPE;
    v_contador NUMBER := 0;
BEGIN
    OPEN c_clientes;
    LOOP
        FETCH c_clientes INTO v_id, v_nombre, v_email, v_telefono;
        EXIT WHEN c_clientes%NOTFOUND;
        v_contador := v_contador + 1;

        IF v_telefono IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE(v_contador || '. ' || UPPER(v_nombre) ||
                ' | ' || LOWER(v_email) ||
                ' | Tel: ' || v_telefono);
        ELSE
            DBMS_OUTPUT.PUT_LINE(v_contador || '. ' || UPPER(v_nombre) ||
                ' | ' || LOWER(v_email) ||
                ' | Tel: SIN TELEFONO');
        END IF;
    END LOOP;
    CLOSE c_clientes;
    DBMS_OUTPUT.PUT_LINE('Total clientes: ' || v_contador);
EXCEPTION
    WHEN OTHERS THEN
        IF c_clientes%ISOPEN THEN CLOSE c_clientes; END IF;
        DBMS_OUTPUT.PUT_LINE('Error en proc_listar_clientes: ' || SQLERRM);
END proc_listar_clientes;
/

-- PROCEDIMIENTO 2: Actualizar el telefono de un cliente
CREATE OR REPLACE PROCEDURE proc_actualizar_telefono(
    p_id_cliente IN clientes.id_cliente%TYPE,
    p_nuevo_tel  IN clientes.telefono%TYPE
) IS
    v_nombre   clientes.nombre%TYPE;
    v_tel_viejo clientes.telefono%TYPE;
    v_existe   NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO v_existe
    FROM clientes WHERE id_cliente = p_id_cliente;

    IF v_existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Cliente con ID ' || p_id_cliente || ' no encontrado.');
    END IF;

    SELECT nombre, telefono INTO v_nombre, v_tel_viejo
    FROM clientes WHERE id_cliente = p_id_cliente;

    IF LENGTH(p_nuevo_tel) < 9 THEN
        RAISE_APPLICATION_ERROR(-20002, 'El telefono debe tener al menos 9 digitos.');
    END IF;

    UPDATE clientes SET telefono = p_nuevo_tel
    WHERE id_cliente = p_id_cliente;
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Cliente:    ' || INITCAP(v_nombre));
    DBMS_OUTPUT.PUT_LINE('Tel. antes: ' || NVL(v_tel_viejo, 'No tenia'));
    DBMS_OUTPUT.PUT_LINE('Tel. nuevo: ' || p_nuevo_tel);
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error en proc_actualizar_telefono: ' || SQLERRM);
END proc_actualizar_telefono;
/

-- FUNCION 1: Contar el total de clientes
CREATE OR REPLACE FUNCTION func_contar_clientes
RETURN NUMBER IS
    v_total NUMBER := 0;
    CURSOR c_todos IS SELECT id_cliente FROM clientes;
    v_id clientes.id_cliente%TYPE;
BEGIN
    OPEN c_todos;
    LOOP
        FETCH c_todos INTO v_id;
        EXIT WHEN c_todos%NOTFOUND;
        v_total := v_total + 1;
    END LOOP;
    CLOSE c_todos;
    RETURN v_total;
EXCEPTION
    WHEN OTHERS THEN
        IF c_todos%ISOPEN THEN CLOSE c_todos; END IF;
        RETURN -1;
END func_contar_clientes;
/

-- FUNCION 2: Obtener el nombre de un cliente por ID
CREATE OR REPLACE FUNCTION func_nombre_cliente(
    p_id IN clientes.id_cliente%TYPE
) RETURN VARCHAR2 IS
    v_nombre    clientes.nombre%TYPE;
    v_resultado VARCHAR2(200);
    CURSOR c_cliente IS
        SELECT nombre FROM clientes WHERE id_cliente = p_id;
BEGIN
    OPEN c_cliente;
    FETCH c_cliente INTO v_nombre;

    IF c_cliente%NOTFOUND THEN
        v_resultado := 'CLIENTE NO ENCONTRADO';
    ELSE
        v_resultado := UPPER(TRIM(v_nombre));
    END IF;

    CLOSE c_cliente;
    RETURN v_resultado;
EXCEPTION
    WHEN OTHERS THEN
        IF c_cliente%ISOPEN THEN CLOSE c_cliente; END IF;
        RETURN 'ERROR: ' || SQLERRM;
END func_nombre_cliente;
/

-- Llamadas de prueba
EXEC proc_listar_clientes;
EXEC proc_actualizar_telefono(1, '666777888');
SELECT func_contar_clientes FROM DUAL;
SELECT func_nombre_cliente(1) FROM DUAL;


-- ============================================================
--  TABLA: USUARIOS
-- ============================================================

-- PROCEDIMIENTO 1: Listar usuarios agrupados por rol
CREATE OR REPLACE PROCEDURE proc_listar_usuarios_por_rol IS
    CURSOR c_roles IS
        SELECT DISTINCT rol FROM usuarios ORDER BY rol;

    CURSOR c_usuarios_rol(p_rol IN VARCHAR2) IS
        SELECT id_usuario, nombre, email
        FROM usuarios
        WHERE rol = p_rol
        ORDER BY nombre;

    v_rol      usuarios.rol%TYPE;
    v_id       usuarios.id_usuario%TYPE;
    v_nombre   usuarios.nombre%TYPE;
    v_email    usuarios.email%TYPE;
    v_contador NUMBER;
BEGIN
    OPEN c_roles;
    LOOP
        FETCH c_roles INTO v_rol;
        EXIT WHEN c_roles%NOTFOUND;

        v_contador := 0;
        DBMS_OUTPUT.PUT_LINE('--- ' || UPPER(v_rol) || ' ---');

        OPEN c_usuarios_rol(v_rol);
        LOOP
            FETCH c_usuarios_rol INTO v_id, v_nombre, v_email;
            EXIT WHEN c_usuarios_rol%NOTFOUND;
            v_contador := v_contador + 1;
            DBMS_OUTPUT.PUT_LINE('  ' || v_contador || '. ' ||
                INITCAP(v_nombre) || ' (' || LOWER(v_email) || ')');
        END LOOP;
        CLOSE c_usuarios_rol;

        IF v_contador = 0 THEN
            DBMS_OUTPUT.PUT_LINE('  Sin usuarios en este rol.');
        END IF;
    END LOOP;
    CLOSE c_roles;
EXCEPTION
    WHEN OTHERS THEN
        IF c_roles%ISOPEN THEN CLOSE c_roles; END IF;
        DBMS_OUTPUT.PUT_LINE('Error en proc_listar_usuarios_por_rol: ' || SQLERRM);
END proc_listar_usuarios_por_rol;
/

-- PROCEDIMIENTO 2: Cambiar el rol de un usuario
CREATE OR REPLACE PROCEDURE proc_cambiar_rol(
    p_id_usuario IN usuarios.id_usuario%TYPE,
    p_nuevo_rol  IN usuarios.rol%TYPE
) IS
    v_nombre    usuarios.nombre%TYPE;
    v_rol_viejo usuarios.rol%TYPE;
    v_existe    NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_existe FROM usuarios WHERE id_usuario = p_id_usuario;

    IF v_existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Usuario con ID ' || p_id_usuario || ' no existe.');
    END IF;

    SELECT nombre, rol INTO v_nombre, v_rol_viejo
    FROM usuarios WHERE id_usuario = p_id_usuario;

    IF LENGTH(TRIM(p_nuevo_rol)) = 0 OR p_nuevo_rol IS NULL THEN
        RAISE_APPLICATION_ERROR(-20004, 'El nuevo rol no puede estar vacio.');
    END IF;

    UPDATE usuarios SET rol = UPPER(TRIM(p_nuevo_rol))
    WHERE id_usuario = p_id_usuario;
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Usuario:    ' || INITCAP(v_nombre));
    DBMS_OUTPUT.PUT_LINE('Rol antes:  ' || v_rol_viejo);
    DBMS_OUTPUT.PUT_LINE('Rol nuevo:  ' || UPPER(TRIM(p_nuevo_rol)));
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error en proc_cambiar_rol: ' || SQLERRM);
END proc_cambiar_rol;
/

-- FUNCION 1: Contar usuarios por rol
CREATE OR REPLACE FUNCTION func_contar_por_rol(
    p_rol IN usuarios.rol%TYPE
) RETURN NUMBER IS
    v_total NUMBER := 0;
    CURSOR c_usuarios IS
        SELECT id_usuario FROM usuarios
        WHERE UPPER(rol) = UPPER(p_rol);
    v_id usuarios.id_usuario%TYPE;
BEGIN
    OPEN c_usuarios;
    LOOP
        FETCH c_usuarios INTO v_id;
        EXIT WHEN c_usuarios%NOTFOUND;
        v_total := v_total + 1;
    END LOOP;
    CLOSE c_usuarios;
    RETURN v_total;
EXCEPTION
    WHEN OTHERS THEN
        IF c_usuarios%ISOPEN THEN CLOSE c_usuarios; END IF;
        RETURN -1;
END func_contar_por_rol;
/

-- FUNCION 2: Comprobar si existe un email de usuario
CREATE OR REPLACE FUNCTION func_email_usuario_existe(
    p_email IN usuarios.email%TYPE
) RETURN NUMBER IS
    v_resultado NUMBER := 0;
    CURSOR c_check IS
        SELECT id_usuario FROM usuarios
        WHERE LOWER(email) = LOWER(p_email);
    v_id usuarios.id_usuario%TYPE;
BEGIN
    OPEN c_check;
    FETCH c_check INTO v_id;

    IF c_check%FOUND THEN
        v_resultado := 1;
    ELSE
        v_resultado := 0;
    END IF;

    CLOSE c_check;
    RETURN v_resultado;
EXCEPTION
    WHEN OTHERS THEN
        IF c_check%ISOPEN THEN CLOSE c_check; END IF;
        RETURN -1;
END func_email_usuario_existe;
/

-- Llamadas de prueba
EXEC proc_listar_usuarios_por_rol;
EXEC proc_cambiar_rol(2, 'ADMIN');
SELECT func_contar_por_rol('ADMIN') FROM DUAL;
SELECT func_email_usuario_existe('admin@crm.com') FROM DUAL;


-- ============================================================
--  TABLA: PRODUCTOS
-- ============================================================

-- PROCEDIMIENTO 1: Listar productos con etiqueta de precio
CREATE OR REPLACE PROCEDURE proc_listar_productos(
    p_precio_umbral IN productos.precio%TYPE DEFAULT 100
) IS
    CURSOR c_productos IS
        SELECT id_producto, nombre, precio, categoria
        FROM productos
        ORDER BY categoria, precio DESC;

    v_id        productos.id_producto%TYPE;
    v_nombre    productos.nombre%TYPE;
    v_precio    productos.precio%TYPE;
    v_categoria productos.categoria%TYPE;
    v_contador  NUMBER := 0;
BEGIN
    OPEN c_productos;
    LOOP
        FETCH c_productos INTO v_id, v_nombre, v_precio, v_categoria;
        EXIT WHEN c_productos%NOTFOUND;
        v_contador := v_contador + 1;

        IF v_precio > p_precio_umbral THEN
            DBMS_OUTPUT.PUT_LINE('[CARO] ' || UPPER(v_nombre) ||
                ' | ' || ROUND(v_precio, 2) || ' EUR | Cat: ' || v_categoria);
        ELSE
            DBMS_OUTPUT.PUT_LINE('[OK]   ' || UPPER(v_nombre) ||
                ' | ' || ROUND(v_precio, 2) || ' EUR | Cat: ' || v_categoria);
        END IF;
    END LOOP;
    CLOSE c_productos;
    DBMS_OUTPUT.PUT_LINE('Total productos: ' || v_contador);
EXCEPTION
    WHEN OTHERS THEN
        IF c_productos%ISOPEN THEN CLOSE c_productos; END IF;
        DBMS_OUTPUT.PUT_LINE('Error en proc_listar_productos: ' || SQLERRM);
END proc_listar_productos;
/

-- PROCEDIMIENTO 2: Aplicar descuento a una categoria (WHERE CURRENT OF)
CREATE OR REPLACE PROCEDURE proc_descuento_categoria(
    p_categoria IN productos.categoria%TYPE,
    p_descuento IN NUMBER
) IS
    CURSOR c_productos_cat IS
        SELECT id_producto, nombre, precio
        FROM productos
        WHERE UPPER(categoria) = UPPER(p_categoria)
        FOR UPDATE;

    v_id          productos.id_producto%TYPE;
    v_nombre      productos.nombre%TYPE;
    v_precio      productos.precio%TYPE;
    v_precio_nuevo productos.precio%TYPE;
    v_contador    NUMBER := 0;
BEGIN
    IF p_descuento <= 0 OR p_descuento >= 100 THEN
        RAISE_APPLICATION_ERROR(-20005, 'El descuento debe estar entre 1 y 99.');
    END IF;

    OPEN c_productos_cat;
    LOOP
        FETCH c_productos_cat INTO v_id, v_nombre, v_precio;
        EXIT WHEN c_productos_cat%NOTFOUND;

        v_precio_nuevo := ROUND(v_precio * (1 - p_descuento / 100), 2);

        UPDATE productos SET precio = v_precio_nuevo
        WHERE CURRENT OF c_productos_cat;

        v_contador := v_contador + 1;
        DBMS_OUTPUT.PUT_LINE(INITCAP(v_nombre) || ': ' ||
            v_precio || ' EUR -> ' || v_precio_nuevo || ' EUR');
    END LOOP;
    CLOSE c_productos_cat;

    IF v_contador = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron productos en: ' || p_categoria);
        ROLLBACK;
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Descuento aplicado a ' || v_contador || ' producto(s).');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        IF c_productos_cat%ISOPEN THEN CLOSE c_productos_cat; END IF;
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error en proc_descuento_categoria: ' || SQLERRM);
END proc_descuento_categoria;
/

-- FUNCION 1: Precio medio de una categoria
CREATE OR REPLACE FUNCTION func_precio_medio_categoria(
    p_categoria IN productos.categoria%TYPE
) RETURN NUMBER IS
    v_suma     NUMBER := 0;
    v_contador NUMBER := 0;
    CURSOR c_precios IS
        SELECT precio FROM productos
        WHERE UPPER(categoria) = UPPER(p_categoria);
    v_precio productos.precio%TYPE;
BEGIN
    OPEN c_precios;
    LOOP
        FETCH c_precios INTO v_precio;
        EXIT WHEN c_precios%NOTFOUND;
        v_suma := v_suma + v_precio;
        v_contador := v_contador + 1;
    END LOOP;
    CLOSE c_precios;

    IF v_contador = 0 THEN RETURN 0; END IF;
    RETURN ROUND(v_suma / v_contador, 2);
EXCEPTION
    WHEN OTHERS THEN
        IF c_precios%ISOPEN THEN CLOSE c_precios; END IF;
        RETURN -1;
END func_precio_medio_categoria;
/

-- FUNCION 2: Comprobar si existe un producto por nombre
CREATE OR REPLACE FUNCTION func_producto_existe(
    p_nombre IN productos.nombre%TYPE
) RETURN NUMBER IS
    v_resultado NUMBER := 0;
    CURSOR c_buscar IS
        SELECT id_producto FROM productos
        WHERE UPPER(nombre) = UPPER(TRIM(p_nombre));
    v_id productos.id_producto%TYPE;
BEGIN
    OPEN c_buscar;
    FETCH c_buscar INTO v_id;

    IF c_buscar%FOUND THEN
        v_resultado := 1;
    ELSE
        v_resultado := 0;
    END IF;

    CLOSE c_buscar;
    RETURN v_resultado;
EXCEPTION
    WHEN OTHERS THEN
        IF c_buscar%ISOPEN THEN CLOSE c_buscar; END IF;
        RETURN -1;
END func_producto_existe;
/

-- Llamadas de prueba
EXEC proc_listar_productos(100);
EXEC proc_descuento_categoria('Informatica', 10);
SELECT func_precio_medio_categoria('Informatica') FROM DUAL;
SELECT func_producto_existe('Monitor Samsung') FROM DUAL;


-- ============================================================
--  TABLA: VENTAS
-- ============================================================

-- PROCEDIMIENTO 1: Resumen de ventas agrupado por estado
CREATE OR REPLACE PROCEDURE proc_resumen_ventas IS
    CURSOR c_estados IS
        SELECT DISTINCT estado FROM ventas ORDER BY estado;

    CURSOR c_ventas_estado(p_estado IN VARCHAR2) IS
        SELECT v.id_venta, c.nombre AS cliente, v.total, v.fecha
        FROM ventas v
        JOIN clientes c ON v.id_cliente = c.id_cliente
        WHERE v.estado = p_estado
        ORDER BY v.total DESC;

    v_estado   ventas.estado%TYPE;
    v_id       ventas.id_venta%TYPE;
    v_cliente  clientes.nombre%TYPE;
    v_total    ventas.total%TYPE;
    v_fecha    ventas.fecha%TYPE;
    v_suma     NUMBER;
    v_contador NUMBER;
BEGIN
    OPEN c_estados;
    LOOP
        FETCH c_estados INTO v_estado;
        EXIT WHEN c_estados%NOTFOUND;

        v_suma := 0;
        v_contador := 0;
        DBMS_OUTPUT.PUT_LINE('--- ' || UPPER(v_estado) || ' ---');

        OPEN c_ventas_estado(v_estado);
        LOOP
            FETCH c_ventas_estado INTO v_id, v_cliente, v_total, v_fecha;
            EXIT WHEN c_ventas_estado%NOTFOUND;
            v_suma := v_suma + v_total;
            v_contador := v_contador + 1;
            DBMS_OUTPUT.PUT_LINE('  Venta #' || v_id ||
                ' | ' || INITCAP(v_cliente) ||
                ' | ' || TO_CHAR(v_total, '9990.00') || ' EUR' ||
                ' | ' || TO_CHAR(v_fecha, 'DD/MM/YYYY'));
        END LOOP;
        CLOSE c_ventas_estado;

        DBMS_OUTPUT.PUT_LINE('  Subtotal: ' || ROUND(v_suma, 2) ||
            ' EUR (' || v_contador || ' ventas)');
    END LOOP;
    CLOSE c_estados;
EXCEPTION
    WHEN OTHERS THEN
        IF c_estados%ISOPEN THEN CLOSE c_estados; END IF;
        DBMS_OUTPUT.PUT_LINE('Error en proc_resumen_ventas: ' || SQLERRM);
END proc_resumen_ventas;
/

-- PROCEDIMIENTO 2: Cambiar el estado de una venta
CREATE OR REPLACE PROCEDURE proc_cambiar_estado_venta(
    p_id_venta    IN ventas.id_venta%TYPE,
    p_nuevo_estado IN ventas.estado%TYPE
) IS
    v_estado_actual ventas.estado%TYPE;
    v_existe        NUMBER;
    v_estado_upper  VARCHAR2(30);
BEGIN
    v_estado_upper := UPPER(TRIM(p_nuevo_estado));

    SELECT COUNT(*) INTO v_existe FROM ventas WHERE id_venta = p_id_venta;
    IF v_existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20006, 'Venta ' || p_id_venta || ' no encontrada.');
    END IF;

    SELECT estado INTO v_estado_actual FROM ventas WHERE id_venta = p_id_venta;

    IF v_estado_upper NOT IN ('PENDIENTE','PAGADA','ENTREGADA','CANCELADA','REVISADA') THEN
        RAISE_APPLICATION_ERROR(-20007, 'Estado no valido: ' || p_nuevo_estado);
    END IF;

    IF v_estado_actual = 'CANCELADA' THEN
        RAISE_APPLICATION_ERROR(-20008, 'No se puede cambiar el estado de una venta CANCELADA.');
    END IF;

    UPDATE ventas SET estado = v_estado_upper WHERE id_venta = p_id_venta;
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Venta #' || p_id_venta ||
        ': ' || v_estado_actual || ' -> ' || v_estado_upper);
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error en proc_cambiar_estado_venta: ' || SQLERRM);
END proc_cambiar_estado_venta;
/

-- FUNCION 1: Total gastado por un cliente (sin canceladas)
CREATE OR REPLACE FUNCTION func_total_cliente(
    p_id_cliente IN ventas.id_cliente%TYPE
) RETURN NUMBER IS
    v_total NUMBER := 0;
    CURSOR c_ventas IS
        SELECT total FROM ventas
        WHERE id_cliente = p_id_cliente
        AND UPPER(estado) != 'CANCELADA';
    v_importe ventas.total%TYPE;
BEGIN
    OPEN c_ventas;
    LOOP
        FETCH c_ventas INTO v_importe;
        EXIT WHEN c_ventas%NOTFOUND;
        v_total := v_total + v_importe;
    END LOOP;
    CLOSE c_ventas;
    RETURN ROUND(v_total, 2);
EXCEPTION
    WHEN OTHERS THEN
        IF c_ventas%ISOPEN THEN CLOSE c_ventas; END IF;
        RETURN -1;
END func_total_cliente;
/

-- FUNCION 2: Contar ventas por estado
CREATE OR REPLACE FUNCTION func_contar_ventas_estado(
    p_estado IN ventas.estado%TYPE
) RETURN NUMBER IS
    v_contador NUMBER := 0;
    CURSOR c_ventas IS
        SELECT id_venta FROM ventas
        WHERE UPPER(estado) = UPPER(p_estado);
    v_id ventas.id_venta%TYPE;
BEGIN
    OPEN c_ventas;
    LOOP
        FETCH c_ventas INTO v_id;
        EXIT WHEN c_ventas%NOTFOUND;
        v_contador := v_contador + 1;
    END LOOP;
    CLOSE c_ventas;
    RETURN v_contador;
EXCEPTION
    WHEN OTHERS THEN
        IF c_ventas%ISOPEN THEN CLOSE c_ventas; END IF;
        RETURN -1;
END func_contar_ventas_estado;
/

-- Llamadas de prueba
EXEC proc_resumen_ventas;
EXEC proc_cambiar_estado_venta(1, 'PAGADA');
SELECT func_total_cliente(1) FROM DUAL;
SELECT func_contar_ventas_estado('PENDIENTE') FROM DUAL;


-- ============================================================
--  TABLA: DETALLE_VENTA
-- ============================================================

-- PROCEDIMIENTO 1: Ver el detalle completo de una venta
CREATE OR REPLACE PROCEDURE proc_detalle_venta(
    p_id_venta IN detalle_venta.id_venta%TYPE
) IS
    CURSOR c_detalle IS
        SELECT dv.id_detalle, p.nombre AS producto,
               dv.cantidad, dv.precio_unitario,
               dv.cantidad * dv.precio_unitario AS subtotal
        FROM detalle_venta dv
        JOIN productos p ON dv.id_producto = p.id_producto
        WHERE dv.id_venta = p_id_venta
        ORDER BY dv.id_detalle;

    v_id_det   detalle_venta.id_detalle%TYPE;
    v_producto productos.nombre%TYPE;
    v_cantidad detalle_venta.cantidad%TYPE;
    v_precio   detalle_venta.precio_unitario%TYPE;
    v_subtotal NUMBER;
    v_total    NUMBER := 0;
    v_lineas   NUMBER := 0;
    v_existe   NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_existe FROM ventas WHERE id_venta = p_id_venta;
    IF v_existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20009, 'La venta ' || p_id_venta || ' no existe.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('=== Detalle venta #' || p_id_venta || ' ===');
    OPEN c_detalle;
    LOOP
        FETCH c_detalle INTO v_id_det, v_producto, v_cantidad, v_precio, v_subtotal;
        EXIT WHEN c_detalle%NOTFOUND;
        v_lineas := v_lineas + 1;
        v_total  := v_total + v_subtotal;

        IF v_cantidad > 1 THEN
            DBMS_OUTPUT.PUT_LINE('  ' || v_lineas || '. ' || UPPER(v_producto) ||
                ' x' || v_cantidad ||
                ' | ' || v_precio || ' EUR/u' ||
                ' | Subtotal: ' || ROUND(v_subtotal, 2) || ' EUR');
        ELSE
            DBMS_OUTPUT.PUT_LINE('  ' || v_lineas || '. ' || UPPER(v_producto) ||
                ' | ' || v_precio || ' EUR');
        END IF;
    END LOOP;
    CLOSE c_detalle;

    IF v_lineas = 0 THEN
        DBMS_OUTPUT.PUT_LINE('  Esta venta no tiene lineas de detalle.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('  TOTAL: ' || ROUND(v_total, 2) ||
            ' EUR (' || v_lineas || ' lineas)');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        IF c_detalle%ISOPEN THEN CLOSE c_detalle; END IF;
        DBMS_OUTPUT.PUT_LINE('Error en proc_detalle_venta: ' || SQLERRM);
END proc_detalle_venta;
/

-- PROCEDIMIENTO 2: Ranking de productos mas vendidos
CREATE OR REPLACE PROCEDURE proc_top_productos IS
    CURSOR c_top IS
        SELECT p.nombre, SUM(dv.cantidad) AS total_uds,
               ROUND(SUM(dv.cantidad * dv.precio_unitario), 2) AS total_eur
        FROM detalle_venta dv
        JOIN productos p ON dv.id_producto = p.id_producto
        GROUP BY p.nombre
        ORDER BY total_uds DESC;

    v_nombre    productos.nombre%TYPE;
    v_total_uds NUMBER;
    v_total_eur NUMBER;
    v_posicion  NUMBER := 0;
BEGIN
    OPEN c_top;
    LOOP
        FETCH c_top INTO v_nombre, v_total_uds, v_total_eur;
        EXIT WHEN c_top%NOTFOUND;
        v_posicion := v_posicion + 1;

        IF v_posicion = 1 THEN
            DBMS_OUTPUT.PUT_LINE('#' || v_posicion || ' [TOP] ' || UPPER(v_nombre) ||
                ' | ' || v_total_uds || ' uds | ' || v_total_eur || ' EUR');
        ELSE
            DBMS_OUTPUT.PUT_LINE('#' || v_posicion || '      ' || UPPER(v_nombre) ||
                ' | ' || v_total_uds || ' uds | ' || v_total_eur || ' EUR');
        END IF;
    END LOOP;
    CLOSE c_top;

    IF v_posicion = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No hay datos de detalle de ventas.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        IF c_top%ISOPEN THEN CLOSE c_top; END IF;
        DBMS_OUTPUT.PUT_LINE('Error en proc_top_productos: ' || SQLERRM);
END proc_top_productos;
/

-- FUNCION 1: Total calculado de una venta desde su detalle
CREATE OR REPLACE FUNCTION func_total_venta(
    p_id_venta IN detalle_venta.id_venta%TYPE
) RETURN NUMBER IS
    v_total NUMBER := 0;
    CURSOR c_lineas IS
        SELECT cantidad, precio_unitario
        FROM detalle_venta WHERE id_venta = p_id_venta;
    v_cantidad detalle_venta.cantidad%TYPE;
    v_precio   detalle_venta.precio_unitario%TYPE;
BEGIN
    OPEN c_lineas;
    LOOP
        FETCH c_lineas INTO v_cantidad, v_precio;
        EXIT WHEN c_lineas%NOTFOUND;
        v_total := v_total + (v_cantidad * v_precio);
    END LOOP;
    CLOSE c_lineas;
    RETURN ROUND(v_total, 2);
EXCEPTION
    WHEN OTHERS THEN
        IF c_lineas%ISOPEN THEN CLOSE c_lineas; END IF;
        RETURN -1;
END func_total_venta;
/

-- FUNCION 2: Contar el numero de lineas de una venta
CREATE OR REPLACE FUNCTION func_lineas_venta(
    p_id_venta IN detalle_venta.id_venta%TYPE
) RETURN NUMBER IS
    v_contador NUMBER := 0;
    CURSOR c_lineas IS
        SELECT id_detalle FROM detalle_venta WHERE id_venta = p_id_venta;
    v_id detalle_venta.id_detalle%TYPE;
BEGIN
    OPEN c_lineas;
    LOOP
        FETCH c_lineas INTO v_id;
        EXIT WHEN c_lineas%NOTFOUND;
        v_contador := v_contador + 1;
    END LOOP;
    CLOSE c_lineas;

    IF v_contador = 0 THEN
        RAISE_APPLICATION_ERROR(-20010, 'La venta ' || p_id_venta || ' no tiene lineas.');
    END IF;

    RETURN v_contador;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        IF c_lineas%ISOPEN THEN CLOSE c_lineas; END IF;
        RETURN -1;
END func_lineas_venta;
/

-- Llamadas de prueba
EXEC proc_detalle_venta(1);
EXEC proc_top_productos;
SELECT func_total_venta(1) FROM DUAL;
SELECT func_lineas_venta(1) FROM DUAL;
