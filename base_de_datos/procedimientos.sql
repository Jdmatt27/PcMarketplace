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
