README BASE DE DATOS

REQUISITOS PREVIOS

- Oracle Database 11g o superior instalado
- SQL*Plus o SQL Developer instalado

PASOS PARA CONFIGURAR EL ENTORNO

1. Abre SQL Developer y conéctate a tu instancia de Oracle con tu usuario y contraseña.

2. En la carpeta base_de_datos estarán los siguientes scripts:

   - ddl_oracle.sql       -> Crea las tablas, secuencias y triggers
   - dml_plsql.sql        -> Inserta, modifica y elimina registros usando bloques PL/SQL
   - cursores.sql         -> 5 consultas con cursores por cada tabla
   - procedimientos.sql   -> 2 procedimientos y 2 funciones por cada tabla

ORDEN DE EJECUCION

3. Ejecuta primero el ddl_oracle.sql.

   3.1. Abre el archivo en SQL Developer.
   3.2. Selecciona todo el contenido y ejecuta con el botón de ejecutar script (F5).
   3.3. Esto creará las 5 tablas, las secuencias y los triggers de auto-incremento.

4. Ejecuta el dml_plsql.sql.

   4.1. Abre el archivo en SQL Developer.
   4.2. Selecciona todo y ejecuta con F5.
   4.3. Este script insertará, modificará y eliminará 5 registros en cada tabla
        usando bloques PL/SQL con control de errores y COMMIT/ROLLBACK.

5. Ejecuta el cursores.sql.

   5.1. Abre el archivo en SQL Developer.
   5.2. Asegúrate de tener activada la salida de DBMS_OUTPUT:
        Ve a Ver -> Salida de DBMS Output -> pulsa el símbolo + y selecciona tu conexión.
   5.3. Selecciona todo y ejecuta con F5.
   5.4. Verás por pantalla el resultado de las 25 consultas (5 por tabla).

6. Ejecuta el procedimientos.sql.

   6.1. Abre el archivo en SQL Developer.
   6.2. Selecciona todo y ejecuta con F5.
   6.3. Este script creará los 10 procedimientos y 10 funciones (2+2 por tabla)
        y realizará llamadas de prueba de cada uno.

ESTRUCTURA DEL PROYECTO

base_de_datos/
├── ddl_oracle.sql        -> Tablas, secuencias y triggers (Oracle)
├── dml_plsql.sql         -> CRUD completo en bloques PL/SQL
├── cursores.sql          -> 5 consultas con cursores por tabla
└── procedimientos.sql    -> 2 procedimientos y 2 funciones por tabla

TABLAS DE LA BASE DE DATOS

- CLIENTES      -> Almacena los clientes del CRM
- USUARIOS      -> Comerciales y administradores del sistema
- PRODUCTOS     -> Catálogo de productos disponibles
- VENTAS        -> Registro de ventas realizadas
- DETALLE_VENTA -> Líneas de producto de cada venta (tabla intermedia)

RELACIONES

- CLIENTES  -> VENTAS        (1:N)
- USUARIOS  -> VENTAS        (1:N)
- VENTAS    -> DETALLE_VENTA (1:N)
- PRODUCTOS -> DETALLE_VENTA (1:N)
- VENTAS    <-> PRODUCTOS    (N:M mediante DETALLE_VENTA)
