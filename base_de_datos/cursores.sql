-- ============================================================
--  PROYECTO CRM - 5 CONSULTAS CON CURSORES POR TABLA
-- ============================================================


-- ============================================================
--  TABLA: CLIENTES
-- ============================================================

-- 1. Listar todos los clientes ordenados por nombre
DECLARE
    CURSOR c_clientes IS
        SELECT id_cliente, nombre, email, telefono, direccion
        FROM clientes
        ORDER BY nombre ASC;

    v_id        clientes.id_cliente%TYPE;
    v_nombre    clientes.nombre%TYPE;
    v_email     clientes.email%TYPE;
    v_telefono  clientes.telefono%TYPE;
    v_direccion clientes.direccion%TYPE;
    v_contador  NUMBER := 0;
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

-- 2. Clientes que tienen telefono registrado
DECLARE
    CURSOR c_con_telefono IS
        SELECT id_cliente, nombre, telefono
        FROM clientes
        WHERE telefono IS NOT NULL
        ORDER BY nombre;

    v_id       clientes.id_cliente%TYPE;
    v_nombre   clientes.nombre%TYPE;
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

-- 3. Clientes sin telefono registrado
DECLARE
    CURSOR c_sin_telefono IS
        SELECT id_cliente, nombre, email
        FROM clientes
        WHERE telefono IS NULL
        ORDER BY nombre;

    v_id       clientes.id_cliente%TYPE;
    v_nombre   clientes.nombre%TYPE;
    v_email    clientes.email%TYPE;
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

-- 4. Buscar un cliente por ID
DECLARE
    v_buscar_id clientes.id_cliente%TYPE := 1;

    CURSOR c_por_id IS
        SELECT id_cliente, nombre, email, telefono, direccion
        FROM clientes
        WHERE id_cliente = v_buscar_id;

    v_id        clientes.id_cliente%TYPE;
    v_nombre    clientes.nombre%TYPE;
    v_email     clientes.email%TYPE;
    v_telefono  clientes.telefono%TYPE;
    v_direccion clientes.direccion%TYPE;
BEGIN
    OPEN c_por_id;
    FETCH c_por_id INTO v_id, v_nombre, v_email, v_telefono, v_direccion;

    IF c_por_id%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('No existe cliente con ID ' || v_buscar_id);
    ELSE
        DBMS_OUTPUT.PUT_LINE('ID:        ' || v_id);
        DBMS_OUTPUT.PUT_LINE('Nombre:    ' || INITCAP(v_nombre));
        DBMS_OUTPUT.PUT_LINE('Email:     ' || LOWER(v_email));
        DBMS_OUTPUT.PUT_LINE('Telefono:  ' || NVL(v_telefono, 'No registrado'));
        DBMS_OUTPUT.PUT_LINE('Direccion: ' || NVL(v_direccion, 'No registrada'));
    END IF;

    CLOSE c_por_id;
EXCEPTION
    WHEN OTHERS THEN
        IF c_por_id%ISOPEN THEN CLOSE c_por_id; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- 5. Clientes agrupados por inicial del nombre
DECLARE
    CURSOR c_por_inicial IS
        SELECT id_cliente, nombre, email
        FROM clientes
        ORDER BY SUBSTR(nombre, 1, 1), nombre;

    v_id       clientes.id_cliente%TYPE;
    v_nombre   clientes.nombre%TYPE;
    v_email    clientes.email%TYPE;
    v_inicial  VARCHAR2(1) := '';
    v_ini_ant  VARCHAR2(1) := '';
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


-- ============================================================
--  TABLA: USUARIOS
-- ============================================================

-- 1. Listar todos los usuarios con su rol
DECLARE
    CURSOR c_usuarios IS
        SELECT id_usuario, nombre, email, rol
        FROM usuarios
        ORDER BY rol, nombre;

    v_id       usuarios.id_usuario%TYPE;
    v_nombre   usuarios.nombre%TYPE;
    v_email    usuarios.email%TYPE;
    v_rol      usuarios.rol%TYPE;
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

-- 2. Usuarios con rol ADMIN
DECLARE
    CURSOR c_admins IS
        SELECT id_usuario, nombre, email
        FROM usuarios
        WHERE UPPER(rol) = 'ADMIN'
        ORDER BY nombre;

    v_id       usuarios.id_usuario%TYPE;
    v_nombre   usuarios.nombre%TYPE;
    v_email    usuarios.email%TYPE;
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

-- 3. Numero de usuarios por cada rol (cursor anidado)
DECLARE
    CURSOR c_roles IS
        SELECT DISTINCT rol FROM usuarios ORDER BY rol;

    CURSOR c_count_rol(p_rol IN VARCHAR2) IS
        SELECT COUNT(*) FROM usuarios
        WHERE UPPER(rol) = UPPER(p_rol);

    v_rol      usuarios.rol%TYPE;
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

-- 4. Buscar usuario por email
DECLARE
    v_buscar usuarios.email%TYPE := 'admin@crm.com';

    CURSOR c_por_email IS
        SELECT id_usuario, nombre, rol
        FROM usuarios
        WHERE LOWER(email) = LOWER(v_buscar);

    v_id     usuarios.id_usuario%TYPE;
    v_nombre usuarios.nombre%TYPE;
    v_rol    usuarios.rol%TYPE;
BEGIN
    OPEN c_por_email;
    FETCH c_por_email INTO v_id, v_nombre, v_rol;

    IF c_por_email%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('No existe usuario con email: ' || v_buscar);
    ELSE
        DBMS_OUTPUT.PUT_LINE('ID:     ' || v_id);
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || INITCAP(v_nombre));
        DBMS_OUTPUT.PUT_LINE('Rol:    ' || UPPER(v_rol));
    END IF;

    CLOSE c_por_email;
EXCEPTION
    WHEN OTHERS THEN
        IF c_por_email%ISOPEN THEN CLOSE c_por_email; END IF;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- 5. Usuarios comerciales ordenados por nombre
DECLARE
    CURSOR c_comerciales IS
        SELECT id_usuario, nombre, email
        FROM usuarios
        WHERE UPPER(rol) = 'COMERCIAL'
        ORDER BY nombre;

    v_id       usuarios.id_usuario%TYPE;
    v_nombre   usuarios.nombre%TYPE;
    v_email    usuarios.email%TYPE;
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


-- ============================================================
