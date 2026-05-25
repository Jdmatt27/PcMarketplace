DECLARE
    CURSOR c_clientes IS
        SELECT id_cliente, nombre, email, telefono, direccion
        FROM clientes
        ORDER BY nombre ASC;

    v_id clientes.id_cliente%TYPE;
    v_nombre clientes.nombre%TYPE;
    v_email clientes.email%TYPE;
    v_telefono clientes.telefono%TYPE;
    v_direccion clientes.direccion%TYPE;
    v_contador NUMBER := 0;
BEGIN
    OPEN c_clientes;
    LOOP
        FETCH c_clientes INTO v_id, v_nombre, v_email, v_telefono, v_direccion;
        EXIT WHEN c_clientes%NOTFOUND;
        v_contador := v_contador + 1;
        DBMS_OUTPUT.PUT_LINE(v_contador || '. ' || UPPER(v_nombre) ||
            ' | ' || LOWER(v_email) ||
            ' | Tel: ' || NVL(v_telefono, 'Sin telefono'));
    END LOOP;
    CLOSE c_clientes;
    DBMS_OUTPUT.PUT_LINE('Total clientes: ' || v_contador);
EXCEPTION
    WHEN OTHERS THEN
        IF c_clientes%ISOPEN THEN CLOSE c_clientes; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    CURSOR c_con_telefono IS
        SELECT id_cliente, nombre, telefono
        FROM clientes
        WHERE telefono IS NOT NULL
        ORDER BY nombre;

    v_id clientes.id_cliente%TYPE;
    v_nombre clientes.nombre%TYPE;
    v_telefono clientes.telefono%TYPE;
    v_contador NUMBER := 0;
BEGIN
    OPEN c_con_telefono;
    LOOP
        FETCH c_con_telefono INTO v_id, v_nombre, v_telefono;
        EXIT WHEN c_con_telefono%NOTFOUND;
        v_contador := v_contador + 1;
        DBMS_OUTPUT.PUT_LINE(v_contador || '. ' || INITCAP(v_nombre) ||
            ' -> ' || v_telefono);
    END LOOP;
    CLOSE c_con_telefono;
    DBMS_OUTPUT.PUT_LINE('Total con telefono: ' || v_contador);
EXCEPTION
    WHEN OTHERS THEN
        IF c_con_telefono%ISOPEN THEN CLOSE c_con_telefono; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    CURSOR c_sin_telefono IS
        SELECT id_cliente, nombre, email
        FROM clientes
        WHERE telefono IS NULL
        ORDER BY nombre;

    v_id clientes.id_cliente%TYPE;
    v_nombre clientes.nombre%TYPE;
    v_email clientes.email%TYPE;
    v_contador NUMBER := 0;
BEGIN
    OPEN c_sin_telefono;
    LOOP
        FETCH c_sin_telefono INTO v_id, v_nombre, v_email;
        EXIT WHEN c_sin_telefono%NOTFOUND;
        v_contador := v_contador + 1;
        DBMS_OUTPUT.PUT_LINE(v_contador || '. ' || INITCAP(v_nombre) ||
            ' | ' || LOWER(v_email));
    END LOOP;
    CLOSE c_sin_telefono;
    DBMS_OUTPUT.PUT_LINE('Total sin telefono: ' || v_contador);
EXCEPTION
    WHEN OTHERS THEN
        IF c_sin_telefono%ISOPEN THEN CLOSE c_sin_telefono; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    v_buscar_id clientes.id_cliente%TYPE := 1;

    CURSOR c_por_id IS
        SELECT id_cliente, nombre, email, telefono, direccion
        FROM clientes
        WHERE id_cliente = v_buscar_id;

    v_id clientes.id_cliente%TYPE;
    v_nombre clientes.nombre%TYPE;
    v_email clientes.email%TYPE;
    v_telefono clientes.telefono%TYPE;
    v_direccion clientes.direccion%TYPE;
BEGIN
    OPEN c_por_id;
    FETCH c_por_id INTO v_id, v_nombre, v_email, v_telefono, v_direccion;

    IF c_por_id%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('No existe cliente con ID ' || v_buscar_id);
    ELSE
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_id);
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || INITCAP(v_nombre));
        DBMS_OUTPUT.PUT_LINE('Email: ' || LOWER(v_email));
        DBMS_OUTPUT.PUT_LINE('Telefono: ' || NVL(v_telefono, 'No registrado'));
        DBMS_OUTPUT.PUT_LINE('Direccion: ' || NVL(v_direccion, 'No registrada'));
    END IF;

    CLOSE c_por_id;
EXCEPTION
    WHEN OTHERS THEN
        IF c_por_id%ISOPEN THEN CLOSE c_por_id; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    CURSOR c_por_inicial IS
        SELECT id_cliente, nombre, email
        FROM clientes
        ORDER BY SUBSTR(nombre, 1, 1), nombre;

    v_id clientes.id_cliente%TYPE;
    v_nombre clientes.nombre%TYPE;
    v_email clientes.email%TYPE;
    v_inicial VARCHAR2(1) := '';
    v_ini_ant VARCHAR2(1) := '';
BEGIN
    OPEN c_por_inicial;
    LOOP
        FETCH c_por_inicial INTO v_id, v_nombre, v_email;
        EXIT WHEN c_por_inicial%NOTFOUND;

        v_inicial := UPPER(SUBSTR(v_nombre, 1, 1));
        IF v_inicial != v_ini_ant THEN
            DBMS_OUTPUT.PUT_LINE('=== ' || v_inicial || ' ===');
            v_ini_ant := v_inicial;
        END IF;

        DBMS_OUTPUT.PUT_LINE('  ' || INITCAP(v_nombre) ||
            ' (' || LOWER(v_email) || ')');
    END LOOP;
    CLOSE c_por_inicial;
EXCEPTION
    WHEN OTHERS THEN
        IF c_por_inicial%ISOPEN THEN CLOSE c_por_inicial; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    CURSOR c_usuarios IS
        SELECT id_usuario, nombre, email, rol
        FROM usuarios
        ORDER BY rol, nombre;

    v_id usuarios.id_usuario%TYPE;
    v_nombre usuarios.nombre%TYPE;
    v_email usuarios.email%TYPE;
    v_rol usuarios.rol%TYPE;
    v_contador NUMBER := 0;
BEGIN
    OPEN c_usuarios;
    LOOP
        FETCH c_usuarios INTO v_id, v_nombre, v_email, v_rol;
        EXIT WHEN c_usuarios%NOTFOUND;
        v_contador := v_contador + 1;
        DBMS_OUTPUT.PUT_LINE(v_contador || '. [' || UPPER(v_rol) || '] ' ||
            INITCAP(v_nombre) || ' | ' || LOWER(v_email));
    END LOOP;
    CLOSE c_usuarios;
    DBMS_OUTPUT.PUT_LINE('Total usuarios: ' || v_contador);
EXCEPTION
    WHEN OTHERS THEN
        IF c_usuarios%ISOPEN THEN CLOSE c_usuarios; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    CURSOR c_admins IS
        SELECT id_usuario, nombre, email
        FROM usuarios
        WHERE UPPER(rol) = 'ADMIN'
        ORDER BY nombre;

    v_id usuarios.id_usuario%TYPE;
    v_nombre usuarios.nombre%TYPE;
    v_email usuarios.email%TYPE;
    v_contador NUMBER := 0;
BEGIN
    OPEN c_admins;
    LOOP
        FETCH c_admins INTO v_id, v_nombre, v_email;
        EXIT WHEN c_admins%NOTFOUND;
        v_contador := v_contador + 1;
        DBMS_OUTPUT.PUT_LINE(v_contador || '. ID ' || v_id ||
            ' | ' || INITCAP(v_nombre) ||
            ' | ' || LOWER(v_email));
    END LOOP;
    CLOSE c_admins;
    DBMS_OUTPUT.PUT_LINE('Total administradores: ' || v_contador);
EXCEPTION
    WHEN OTHERS THEN
        IF c_admins%ISOPEN THEN CLOSE c_admins; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    CURSOR c_roles IS
        SELECT DISTINCT rol FROM usuarios ORDER BY rol;

    CURSOR c_count_rol(p_rol IN VARCHAR2) IS
        SELECT COUNT(*) FROM usuarios
        WHERE UPPER(rol) = UPPER(p_rol);

    v_rol usuarios.rol%TYPE;
    v_cantidad NUMBER;
BEGIN
    OPEN c_roles;
    LOOP
        FETCH c_roles INTO v_rol;
        EXIT WHEN c_roles%NOTFOUND;

        OPEN c_count_rol(v_rol);
        FETCH c_count_rol INTO v_cantidad;
        CLOSE c_count_rol;

        DBMS_OUTPUT.PUT_LINE('Rol: ' || UPPER(v_rol) ||
            ' -> ' || v_cantidad || ' usuario(s)');
    END LOOP;
    CLOSE c_roles;
EXCEPTION
    WHEN OTHERS THEN
        IF c_roles%ISOPEN THEN CLOSE c_roles; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    v_buscar usuarios.email%TYPE := 'admin@crm.com';

    CURSOR c_por_email IS
        SELECT id_usuario, nombre, rol
        FROM usuarios
        WHERE LOWER(email) = LOWER(v_buscar);

    v_id usuarios.id_usuario%TYPE;
    v_nombre usuarios.nombre%TYPE;
    v_rol usuarios.rol%TYPE;
BEGIN
    OPEN c_por_email;
    FETCH c_por_email INTO v_id, v_nombre, v_rol;

    IF c_por_email%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('No existe usuario con email: ' || v_buscar);
    ELSE
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_id);
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || INITCAP(v_nombre));
        DBMS_OUTPUT.PUT_LINE('Rol: ' || UPPER(v_rol));
    END IF;

    CLOSE c_por_email;
EXCEPTION
    WHEN OTHERS THEN
        IF c_por_email%ISOPEN THEN CLOSE c_por_email; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    CURSOR c_comerciales IS
        SELECT id_usuario, nombre, email
        FROM usuarios
        WHERE UPPER(rol) = 'COMERCIAL'
        ORDER BY nombre;

    v_id usuarios.id_usuario%TYPE;
    v_nombre usuarios.nombre%TYPE;
    v_email usuarios.email%TYPE;
    v_contador NUMBER := 0;
BEGIN
    OPEN c_comerciales;
    LOOP
        FETCH c_comerciales INTO v_id, v_nombre, v_email;
        EXIT WHEN c_comerciales%NOTFOUND;
        v_contador := v_contador + 1;
        DBMS_OUTPUT.PUT_LINE(v_contador || '. ' || INITCAP(v_nombre) ||
            ' | ' || LOWER(v_email));
    END LOOP;
    CLOSE c_comerciales;

    IF v_contador = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No hay comerciales registrados.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Total comerciales: ' || v_contador);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        IF c_comerciales%ISOPEN THEN CLOSE c_comerciales; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    CURSOR c_productos IS
        SELECT id_producto, nombre, precio, categoria
        FROM productos
        ORDER BY categoria, nombre;

    v_id productos.id_producto%TYPE;
    v_nombre productos.nombre%TYPE;
    v_precio productos.precio%TYPE;
    v_categoria productos.categoria%TYPE;
    v_contador NUMBER := 0;
BEGIN
    OPEN c_productos;
    LOOP
        FETCH c_productos INTO v_id, v_nombre, v_precio, v_categoria;
        EXIT WHEN c_productos%NOTFOUND;
        v_contador := v_contador + 1;
        DBMS_OUTPUT.PUT_LINE(v_contador || '. [' || UPPER(v_categoria) || '] ' ||
            UPPER(v_nombre) || ' -> ' || ROUND(v_precio, 2) || ' EUR');
    END LOOP;
    CLOSE c_productos;
    DBMS_OUTPUT.PUT_LINE('Total productos: ' || v_contador);
EXCEPTION
    WHEN OTHERS THEN
        IF c_productos%ISOPEN THEN CLOSE c_productos; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    v_umbral productos.precio%TYPE := 100;

    CURSOR c_caros IS
        SELECT id_producto, nombre, precio, categoria
        FROM productos
        WHERE precio > v_umbral
        ORDER BY precio DESC;

    v_id productos.id_producto%TYPE;
    v_nombre productos.nombre%TYPE;
    v_precio productos.precio%TYPE;
    v_categoria productos.categoria%TYPE;
    v_contador NUMBER := 0;
BEGIN
    OPEN c_caros;
    LOOP
        FETCH c_caros INTO v_id, v_nombre, v_precio, v_categoria;
        EXIT WHEN c_caros%NOTFOUND;
        v_contador := v_contador + 1;
        DBMS_OUTPUT.PUT_LINE(v_contador || '. ' || UPPER(v_nombre) ||
            ' | ' || ROUND(v_precio, 2) || ' EUR' ||
            ' | Cat: ' || v_categoria);
    END LOOP;
    CLOSE c_caros;
    DBMS_OUTPUT.PUT_LINE('Productos por encima de ' || v_umbral || ' EUR: ' || v_contador);
EXCEPTION
    WHEN OTHERS THEN
        IF c_caros%ISOPEN THEN CLOSE c_caros; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    CURSOR c_categorias IS
        SELECT DISTINCT categoria FROM productos ORDER BY categoria;

    CURSOR c_media(p_cat IN VARCHAR2) IS
        SELECT COUNT(*), ROUND(AVG(precio), 2)
        FROM productos
        WHERE UPPER(categoria) = UPPER(p_cat);

    v_categoria productos.categoria%TYPE;
    v_cantidad NUMBER;
    v_media NUMBER;
BEGIN
    OPEN c_categorias;
    LOOP
        FETCH c_categorias INTO v_categoria;
        EXIT WHEN c_categorias%NOTFOUND;

        OPEN c_media(v_categoria);
        FETCH c_media INTO v_cantidad, v_media;
        CLOSE c_media;

        DBMS_OUTPUT.PUT_LINE('Categoria: ' || UPPER(v_categoria) ||
            ' | Productos: ' || v_cantidad ||
            ' | Precio medio: ' || v_media || ' EUR');
    END LOOP;
    CLOSE c_categorias;
EXCEPTION
    WHEN OTHERS THEN
        IF c_categorias%ISOPEN THEN CLOSE c_categorias; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    v_buscar productos.nombre%TYPE := 'Monitor Samsung';

    CURSOR c_por_nombre IS
        SELECT id_producto, nombre, descripcion, precio, categoria
        FROM productos
        WHERE UPPER(nombre) = UPPER(TRIM(v_buscar));

    v_id productos.id_producto%TYPE;
    v_nombre productos.nombre%TYPE;
    v_desc productos.descripcion%TYPE;
    v_precio productos.precio%TYPE;
    v_categoria productos.categoria%TYPE;
BEGIN
    OPEN c_por_nombre;
    FETCH c_por_nombre INTO v_id, v_nombre, v_desc, v_precio, v_categoria;

    IF c_por_nombre%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('Producto no encontrado: ' || v_buscar);
    ELSE
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_id);
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || INITCAP(v_nombre));
        DBMS_OUTPUT.PUT_LINE('Descripcion: ' || NVL(v_desc, 'Sin descripcion'));
        DBMS_OUTPUT.PUT_LINE('Precio: ' || ROUND(v_precio, 2) || ' EUR');
        DBMS_OUTPUT.PUT_LINE('Categoria: ' || v_categoria);
    END IF;

    CLOSE c_por_nombre;
EXCEPTION
    WHEN OTHERS THEN
        IF c_por_nombre%ISOPEN THEN CLOSE c_por_nombre; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    CURSOR c_ranking IS
        SELECT id_producto, nombre, precio, categoria
        FROM productos
        ORDER BY precio DESC;

    v_id productos.id_producto%TYPE;
    v_nombre productos.nombre%TYPE;
    v_precio productos.precio%TYPE;
    v_categoria productos.categoria%TYPE;
    v_pos NUMBER := 0;
    v_etiqueta VARCHAR2(10);
BEGIN
    OPEN c_ranking;
    LOOP
        FETCH c_ranking INTO v_id, v_nombre, v_precio, v_categoria;
        EXIT WHEN c_ranking%NOTFOUND;
        v_pos := v_pos + 1;

        IF v_precio > 500 THEN
            v_etiqueta := '[PREMIUM]';
        ELSIF v_precio > 100 THEN
            v_etiqueta := '[MEDIO]  ';
        ELSE
            v_etiqueta := '[BASICO] ';
        END IF;

        DBMS_OUTPUT.PUT_LINE('#' || v_pos || ' ' || v_etiqueta ||
            ' ' || UPPER(v_nombre) ||
            ' | ' || ROUND(v_precio, 2) || ' EUR');
    END LOOP;
    CLOSE c_ranking;
EXCEPTION
    WHEN OTHERS THEN
        IF c_ranking%ISOPEN THEN CLOSE c_ranking; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    CURSOR c_ventas IS
        SELECT v.id_venta, c.nombre AS cliente, u.nombre AS usuario,
               v.total, v.estado, v.fecha
        FROM ventas v
        JOIN clientes c ON v.id_cliente = c.id_cliente
        JOIN usuarios u ON v.id_usuario = u.id_usuario
        ORDER BY v.fecha DESC;

    v_id ventas.id_venta%TYPE;
    v_cliente clientes.nombre%TYPE;
    v_usuario usuarios.nombre%TYPE;
    v_total ventas.total%TYPE;
    v_estado ventas.estado%TYPE;
    v_fecha ventas.fecha%TYPE;
    v_contador NUMBER := 0;
BEGIN
    OPEN c_ventas;
    LOOP
        FETCH c_ventas INTO v_id, v_cliente, v_usuario, v_total, v_estado, v_fecha;
        EXIT WHEN c_ventas%NOTFOUND;
        v_contador := v_contador + 1;
        DBMS_OUTPUT.PUT_LINE('Venta #' || v_id ||
            ' | ' || INITCAP(v_cliente) ||
            ' | ' || INITCAP(v_usuario) ||
            ' | ' || TO_CHAR(v_total, '9990.00') || ' EUR' ||
            ' | ' || UPPER(v_estado) ||
            ' | ' || TO_CHAR(v_fecha, 'DD/MM/YYYY'));
    END LOOP;
    CLOSE c_ventas;
    DBMS_OUTPUT.PUT_LINE('Total ventas: ' || v_contador);
EXCEPTION
    WHEN OTHERS THEN
        IF c_ventas%ISOPEN THEN CLOSE c_ventas; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    CURSOR c_pendientes IS
        SELECT v.id_venta, c.nombre AS cliente, v.total, v.fecha
        FROM ventas v
        JOIN clientes c ON v.id_cliente = c.id_cliente
        WHERE UPPER(v.estado) = 'PENDIENTE'
        ORDER BY v.fecha ASC;

    v_id ventas.id_venta%TYPE;
    v_cliente clientes.nombre%TYPE;
    v_total ventas.total%TYPE;
    v_fecha ventas.fecha%TYPE;
    v_suma NUMBER := 0;
    v_contador NUMBER := 0;
BEGIN
    OPEN c_pendientes;
    LOOP
        FETCH c_pendientes INTO v_id, v_cliente, v_total, v_fecha;
        EXIT WHEN c_pendientes%NOTFOUND;
        v_contador := v_contador + 1;
        v_suma := v_suma + v_total;
        DBMS_OUTPUT.PUT_LINE('Venta #' || v_id ||
            ' | ' || INITCAP(v_cliente) ||
            ' | ' || ROUND(v_total, 2) || ' EUR' ||
            ' | Fecha: ' || TO_CHAR(v_fecha, 'DD/MM/YYYY'));
    END LOOP;
    CLOSE c_pendientes;
    DBMS_OUTPUT.PUT_LINE('Total pendiente: ' || ROUND(v_suma, 2) ||
        ' EUR (' || v_contador || ' ventas)');
EXCEPTION
    WHEN OTHERS THEN
        IF c_pendientes%ISOPEN THEN CLOSE c_pendientes; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    CURSOR c_estados IS
        SELECT DISTINCT estado FROM ventas ORDER BY estado;

    CURSOR c_por_estado(p_estado IN VARCHAR2) IS
        SELECT v.id_venta, c.nombre AS cliente, v.total
        FROM ventas v
        JOIN clientes c ON v.id_cliente = c.id_cliente
        WHERE UPPER(v.estado) = UPPER(p_estado)
        ORDER BY v.total DESC;

    v_estado ventas.estado%TYPE;
    v_id ventas.id_venta%TYPE;
    v_cliente clientes.nombre%TYPE;
    v_total ventas.total%TYPE;
    v_suma NUMBER;
    v_contador NUMBER;
BEGIN
    OPEN c_estados;
    LOOP
        FETCH c_estados INTO v_estado;
        EXIT WHEN c_estados%NOTFOUND;

        v_suma := 0;
        v_contador := 0;
        DBMS_OUTPUT.PUT_LINE('--- ' || UPPER(v_estado) || ' ---');

        OPEN c_por_estado(v_estado);
        LOOP
            FETCH c_por_estado INTO v_id, v_cliente, v_total;
            EXIT WHEN c_por_estado%NOTFOUND;
            v_suma := v_suma + v_total;
            v_contador := v_contador + 1;
            DBMS_OUTPUT.PUT_LINE('  Venta #' || v_id ||
                ' | ' || INITCAP(v_cliente) ||
                ' | ' || ROUND(v_total, 2) || ' EUR');
        END LOOP;
        CLOSE c_por_estado;

        DBMS_OUTPUT.PUT_LINE('  Subtotal: ' || ROUND(v_suma, 2) ||
            ' EUR (' || v_contador || ' ventas)');
    END LOOP;
    CLOSE c_estados;
EXCEPTION
    WHEN OTHERS THEN
        IF c_estados%ISOPEN THEN CLOSE c_estados; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    v_id_cliente ventas.id_cliente%TYPE := 1;

    CURSOR c_ventas_cliente IS
        SELECT id_venta, total, estado, fecha
        FROM ventas
        WHERE id_cliente = v_id_cliente
        ORDER BY fecha DESC;

    v_id ventas.id_venta%TYPE;
    v_total ventas.total%TYPE;
    v_estado ventas.estado%TYPE;
    v_fecha ventas.fecha%TYPE;
    v_suma NUMBER := 0;
    v_contador NUMBER := 0;
BEGIN
    OPEN c_ventas_cliente;
    LOOP
        FETCH c_ventas_cliente INTO v_id, v_total, v_estado, v_fecha;
        EXIT WHEN c_ventas_cliente%NOTFOUND;
        v_contador := v_contador + 1;
        v_suma := v_suma + v_total;
        DBMS_OUTPUT.PUT_LINE('Venta #' || v_id ||
            ' | ' || ROUND(v_total, 2) || ' EUR' ||
            ' | ' || UPPER(v_estado) ||
            ' | ' || TO_CHAR(v_fecha, 'DD/MM/YYYY'));
    END LOOP;
    CLOSE c_ventas_cliente;

    IF v_contador = 0 THEN
        DBMS_OUTPUT.PUT_LINE('El cliente ' || v_id_cliente || ' no tiene ventas.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Total gastado: ' || ROUND(v_suma, 2) ||
            ' EUR (' || v_contador || ' ventas)');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        IF c_ventas_cliente%ISOPEN THEN CLOSE c_ventas_cliente; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    CURSOR c_ranking IS
        SELECT v.id_venta, c.nombre AS cliente, v.total, v.estado
        FROM ventas v
        JOIN clientes c ON v.id_cliente = c.id_cliente
        ORDER BY v.total DESC;

    v_id ventas.id_venta%TYPE;
    v_cliente clientes.nombre%TYPE;
    v_total ventas.total%TYPE;
    v_estado ventas.estado%TYPE;
    v_pos NUMBER := 0;
    v_etiqueta VARCHAR2(10);
BEGIN
    OPEN c_ranking;
    LOOP
        FETCH c_ranking INTO v_id, v_cliente, v_total, v_estado;
        EXIT WHEN c_ranking%NOTFOUND;
        v_pos := v_pos + 1;

        IF v_pos = 1 THEN
            v_etiqueta := '[TOP]   ';
        ELSIF v_total > 500 THEN
            v_etiqueta := '[ALTA]  ';
        ELSE
            v_etiqueta := '[NORMAL]';
        END IF;

        DBMS_OUTPUT.PUT_LINE('#' || v_pos || ' ' || v_etiqueta ||
            ' Venta #' || v_id ||
            ' | ' || INITCAP(v_cliente) ||
            ' | ' || ROUND(v_total, 2) || ' EUR' ||
            ' | ' || UPPER(v_estado));
    END LOOP;
    CLOSE c_ranking;
EXCEPTION
    WHEN OTHERS THEN
        IF c_ranking%ISOPEN THEN CLOSE c_ranking; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    CURSOR c_detalle IS
        SELECT dv.id_detalle, dv.id_venta, p.nombre AS producto,
               dv.cantidad, dv.precio_unitario,
               dv.cantidad * dv.precio_unitario AS subtotal
        FROM detalle_venta dv
        JOIN productos p ON dv.id_producto = p.id_producto
        ORDER BY dv.id_venta, dv.id_detalle;

    v_id_det detalle_venta.id_detalle%TYPE;
    v_id_venta detalle_venta.id_venta%TYPE;
    v_producto productos.nombre%TYPE;
    v_cantidad detalle_venta.cantidad%TYPE;
    v_precio detalle_venta.precio_unitario%TYPE;
    v_subtotal NUMBER;
BEGIN
    OPEN c_detalle;
    LOOP
        FETCH c_detalle INTO v_id_det, v_id_venta, v_producto,
                             v_cantidad, v_precio, v_subtotal;
        EXIT WHEN c_detalle%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Detalle #' || v_id_det ||
            ' | Venta #' || v_id_venta ||
            ' | ' || UPPER(v_producto) ||
            ' x' || v_cantidad ||
            ' | ' || v_precio || ' EUR/u' ||
            ' | Subtotal: ' || ROUND(v_subtotal, 2) || ' EUR');
    END LOOP;
    CLOSE c_detalle;
EXCEPTION
    WHEN OTHERS THEN
        IF c_detalle%ISOPEN THEN CLOSE c_detalle; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    v_id_venta detalle_venta.id_venta%TYPE := 1;

    CURSOR c_detalle_venta IS
        SELECT dv.id_detalle, p.nombre AS producto,
               dv.cantidad, dv.precio_unitario,
               dv.cantidad * dv.precio_unitario AS subtotal
        FROM detalle_venta dv
        JOIN productos p ON dv.id_producto = p.id_producto
        WHERE dv.id_venta = v_id_venta
        ORDER BY dv.id_detalle;

    v_id_det detalle_venta.id_detalle%TYPE;
    v_producto productos.nombre%TYPE;
    v_cantidad detalle_venta.cantidad%TYPE;
    v_precio detalle_venta.precio_unitario%TYPE;
    v_subtotal NUMBER;
    v_total NUMBER := 0;
    v_lineas NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== Detalle venta #' || v_id_venta || ' ===');
    OPEN c_detalle_venta;
    LOOP
        FETCH c_detalle_venta INTO v_id_det, v_producto,
                                   v_cantidad, v_precio, v_subtotal;
        EXIT WHEN c_detalle_venta%NOTFOUND;
        v_lineas := v_lineas + 1;
        v_total := v_total + v_subtotal;
        DBMS_OUTPUT.PUT_LINE('  ' || v_lineas || '. ' || UPPER(v_producto) ||
            ' x' || v_cantidad ||
            ' a ' || v_precio || ' EUR/u' ||
            ' = ' || ROUND(v_subtotal, 2) || ' EUR');
    END LOOP;
    CLOSE c_detalle_venta;

    IF v_lineas = 0 THEN
        DBMS_OUTPUT.PUT_LINE('  Esta venta no tiene lineas de detalle.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('  TOTAL: ' || ROUND(v_total, 2) ||
            ' EUR (' || v_lineas || ' lineas)');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        IF c_detalle_venta%ISOPEN THEN CLOSE c_detalle_venta; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    CURSOR c_top IS
        SELECT p.nombre, SUM(dv.cantidad) AS total_uds,
               ROUND(SUM(dv.cantidad * dv.precio_unitario), 2) AS total_eur
        FROM detalle_venta dv
        JOIN productos p ON dv.id_producto = p.id_producto
        GROUP BY p.nombre
        ORDER BY total_uds DESC;

    v_nombre productos.nombre%TYPE;
    v_total_uds NUMBER;
    v_total_eur NUMBER;
    v_pos NUMBER := 0;
BEGIN
    OPEN c_top;
    LOOP
        FETCH c_top INTO v_nombre, v_total_uds, v_total_eur;
        EXIT WHEN c_top%NOTFOUND;
        v_pos := v_pos + 1;
        DBMS_OUTPUT.PUT_LINE('#' || v_pos ||
            ' ' || UPPER(v_nombre) ||
            ' | ' || v_total_uds || ' uds' ||
            ' | ' || v_total_eur || ' EUR');
    END LOOP;
    CLOSE c_top;

    IF v_pos = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No hay datos de ventas todavia.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        IF c_top%ISOPEN THEN CLOSE c_top; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    CURSOR c_multiplos IS
        SELECT dv.id_detalle, dv.id_venta, p.nombre AS producto,
               dv.cantidad, dv.precio_unitario,
               dv.cantidad * dv.precio_unitario AS subtotal
        FROM detalle_venta dv
        JOIN productos p ON dv.id_producto = p.id_producto
        WHERE dv.cantidad > 1
        ORDER BY dv.cantidad DESC;

    v_id_det detalle_venta.id_detalle%TYPE;
    v_id_venta detalle_venta.id_venta%TYPE;
    v_producto productos.nombre%TYPE;
    v_cantidad detalle_venta.cantidad%TYPE;
    v_precio detalle_venta.precio_unitario%TYPE;
    v_subtotal NUMBER;
    v_contador NUMBER := 0;
BEGIN
    OPEN c_multiplos;
    LOOP
        FETCH c_multiplos INTO v_id_det, v_id_venta, v_producto,
                               v_cantidad, v_precio, v_subtotal;
        EXIT WHEN c_multiplos%NOTFOUND;
        v_contador := v_contador + 1;
        DBMS_OUTPUT.PUT_LINE('Venta #' || v_id_venta ||
            ' | ' || UPPER(v_producto) ||
            ' x' || v_cantidad ||
            ' | Subtotal: ' || ROUND(v_subtotal, 2) || ' EUR');
    END LOOP;
    CLOSE c_multiplos;
    DBMS_OUTPUT.PUT_LINE('Lineas con cantidad > 1: ' || v_contador);
EXCEPTION
    WHEN OTHERS THEN
        IF c_multiplos%ISOPEN THEN CLOSE c_multiplos; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    CURSOR c_ventas_ids IS
        SELECT DISTINCT id_venta FROM detalle_venta ORDER BY id_venta;

    CURSOR c_resumen(p_id IN NUMBER) IS
        SELECT COUNT(*), ROUND(SUM(cantidad * precio_unitario), 2)
        FROM detalle_venta
        WHERE id_venta = p_id;

    v_id_venta detalle_venta.id_venta%TYPE;
    v_lineas NUMBER;
    v_total NUMBER;
BEGIN
    OPEN c_ventas_ids;
    LOOP
        FETCH c_ventas_ids INTO v_id_venta;
        EXIT WHEN c_ventas_ids%NOTFOUND;

        OPEN c_resumen(v_id_venta);
        FETCH c_resumen INTO v_lineas, v_total;
        CLOSE c_resumen;

        DBMS_OUTPUT.PUT_LINE('Venta #' || v_id_venta ||
            ' | Lineas: ' || v_lineas ||
            ' | Total: ' || NVL(TO_CHAR(v_total), '0.00') || ' EUR');
    END LOOP;
    CLOSE c_ventas_ids;
EXCEPTION
    WHEN OTHERS THEN
        IF c_ventas_ids%ISOPEN THEN CLOSE c_ventas_ids; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/