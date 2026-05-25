# PcMarketplace – CRM Tienda de Componentes Hardware

> Proyecto intermodular 3er trimestre · 1º DAM · XTART Formación Profesional  
> **Juan David Matteucci Angel · Javier Clemente Barahona**

---

## Descripción del proyecto

**PcMarketplace** es un sistema CRM (Customer Relationship Management) desarrollado para gestionar la operativa de una tienda de componentes de hardware para ordenadores. El proyecto integra cuatro módulos del ciclo DAM:

| Módulo | Tecnología | Descripción |
|---|---|---|
| **Programación** | Java 17 + JDBC + MySQL | Aplicación de consola con CRUD completo |
| **Base de Datos** | Oracle Database + PL/SQL | Modelo relacional, cursores, procedimientos y funciones |
| **Lenguaje de Marcas** | HTML5 + CSS3 + JavaScript | Aplicación web con CRUD y SessionStorage |
| **Entornos de Desarrollo** | Git + GitHub | Control de versiones, ramas, stash, rebase y tags |

---

## Estructura del repositorio

```
PcMarketplace/
│
├── src/main/java/com/pcmarketplace/
│   ├── controllers/          → CustomerController, ProductController,
│   │                           SaleController, SaleDetailController, UserController
│   ├── models/               → BaseEntity, Customer, Product, Sale, SaleDetail, User
│   ├── repositories/         → Interfaces Repository<T,ID> + implementaciones JDBC
│   ├── services/             → CustomerService, ProductService,
│   │                           SaleService, SaleDetailService, UserService
│   ├── util/                 → DataBaseConection.java, ExportUtil.java
│   ├── Main.java             → Punto de entrada de la aplicación
│   └── Menu.java             → Menú principal de consola
│
├── base_de_datos/            → Scripts Oracle y MySQL
│   ├── ddl_plsqlp.sql        → DDL Oracle: tablas, secuencias y triggers
│   ├── dml_plsql.sql         → DML Oracle: inserción, modificación y eliminación (PL/SQL)
│   ├── cursores.sql          → 25 consultas con cursores explícitos (5 por tabla)
│   ├── procedimientos.sql    → 20 objetos PL/SQL: 2 procedimientos + 2 funciones por tabla
│   └── README_base_de_datos.txt → Instrucciones específicas de Oracle
│
├── lenguaje_de_marcas/       → Aplicación web completa
│   ├── index.html            → Dashboard principal del CRM
│   ├── clientes/             → CRUD de clientes (HTML + JS)
│   ├── usuarios/             → CRUD de usuarios (HTML + JS)
│   ├── productos/            → CRUD de productos (HTML + JS)
│   ├── ventas/               → CRUD de ventas (HTML + JS)
│   ├── detalle-venta/        → CRUD de detalle de ventas (HTML + JS)
│   └── css/                  → main.css, components.css, responsive.css
│
├── pom.xml                   → Descriptor Maven (dependencia MySQL Connector/J)
└── README.md                 → Este archivo
```

> Los scripts de Base de Datos se encuentran en la rama **`feature/juanda/base-datos`**.  
> Los scripts MySQL (`ddl_mysql` y `dml_mysql`) están en la carpeta **`script/`** de la rama **`main`**.

---

## Ramas del repositorio

| Rama | Autor | Contenido |
|---|---|---|
| `main` | Ambos | Versión estable e integrada del proyecto completo |
| `feature/juanda/programacion` | Juanda | Sale/User/SaleDetail: repos, servicios, controllers, Menu, Main, ExportUtil |
| `feature/javier/programacion` | Javier | BaseEntity, modelos, CustomerRepo, ProductRepo, DDL MySQL |
| `feature/juanda/lenguaje-marcas` | Juanda | Aplicación web completa (HTML/CSS/JS, 5 módulos CRUD) |
| `feature/javier/lenguaje-marcas` | Javier | Módulos web: Usuarios, Productos, Detalle de Venta |
| `feature/juanda/base-datos` | Juanda | DDL Oracle, DML PL/SQL, cursores, procedimientos y funciones |
| `feature/javier/base-datos` | Javier | DDL Oracle alternativo, cursores adicionales |

---

## Versiones (Tags)

| Tag | Descripción |
|---|---|
| `v1.0-bd` | Primera versión funcional de los scripts de Base de Datos Oracle |
| `v1.0-java` | Primera versión funcional de la aplicación Java con CRUD completo |
| `v1.0-web` | Primera versión funcional de la aplicación web con SessionStorage |
| `v1.0` | Versión final integrada del proyecto completo |

---

## Requisitos previos

### Para la aplicación Java (Programación)
- Java JDK 17 o superior → [Descargar](https://www.oracle.com/java/technologies/downloads/#java17)
- IntelliJ IDEA Community → [Descargar](https://www.jetbrains.com/idea/download/)
- MySQL Server 8.0 → [Descargar](https://dev.mysql.com/downloads/mysql/)
- MySQL Workbench 8.0 → [Descargar](https://dev.mysql.com/downloads/workbench/)
- Maven (viene incluido con IntelliJ IDEA, no requiere instalación adicional)

### Para la aplicación Web (Lenguaje de Marcas)
- Cualquier navegador moderno (Chrome, Firefox, Edge)
- Visual Studio Code (opcional, para editar el código) → [Descargar](https://code.visualstudio.com/)
- Extensión Live Server para VS Code (opcional, para servidor local)

### Para los scripts de Base de Datos Oracle (Base de Datos)
- Oracle Database 11g o superior (o acceso a un servidor Oracle)
- Oracle SQL Developer → [Descargar](https://www.oracle.com/database/sqldeveloper/technologies/download/)

---

## Cómo configurar y ejecutar el proyecto

### Clonar el repositorio

```bash
git clone https://github.com/Jdmatt27/PcMarketplace.git
cd PcMarketplace
```

---

### Configurar la Base de Datos MySQL (para la aplicación Java)

#### 2.1 Crear el schema en MySQL Workbench

1. Abre **MySQL Workbench** y conéctate a tu servidor local.
2. En el panel izquierdo (Navigator), haz clic derecho sobre el área de schemas y selecciona **Create Schema**.
3. Ponle el nombre `crm` y haz clic en **Apply**.

#### 2.2 Ejecutar el script DDL (crea las tablas)

1. En MySQL Workbench, haz doble clic sobre el schema `crm` para seleccionarlo.
2. Ve a **File → Open SQL Script** y abre el archivo `script/ddl_mysql.sql`.
3. Selecciona todo el contenido (`Ctrl+A`) y haz clic en el **rayo (⚡ Execute All)**.
4. Refresca los schemas en el panel izquierdo. Deberías ver las tablas `clientes`, `usuarios`, `productos`, `ventas` y `detalle_venta` dentro del schema `crm`.

#### 2.3 Ejecutar el script DML (carga los datos de prueba)

1. Ve a **File → Open SQL Script** y abre el archivo `script/dml_mysql.sql`.
2. Selecciona todo el contenido (`Ctrl+A`) y haz clic en el **rayo (⚡ Execute All)**.
3. Las tablas quedarán cargadas con datos de prueba reales de PcMarketplace.

---

### Configurar la conexión a MySQL en el proyecto Java

Abre el archivo:
```
src/main/java/com/pcmarketplace/util/DataBaseConection.java
```

Localiza estas tres líneas y ajústalas a tu entorno:

```java
private static final String URL = "jdbc:mysql://localhost:3306/crm";
private static final String USER = "root";
private static final String PASSWORD = "tu_contraseña_aqui";
```

| Campo | Qué modificar |
|---|---|
| `3306` | Cambia el puerto si MySQL usa uno diferente en tu máquina |
| `root` | Pon el usuario de tu instalación de MySQL |
| `tu_contraseña_aqui` | Pon la contraseña que configuraste al instalar MySQL |

---

### Ejecutar la aplicación Java

README PROGRAMACION

REQUISITOS PREVIOS

    - Java JDK 17 o superior instalado
    - IntelliJ IDEA instalado
    - MySQL Server 8.0 instalado
    - MySQL Workbench instalado
    - Maven (viene incluido con IntelliJ)

PASOS PARA CONFIGURAR EL ENTORNO

0. Si no te deja ejecutar la Main, pulsa click derecho en pom.xml, busca la opcion que tenga add as maven y continuas.

1. Abre SQL Workbench y selecciona tu conexion de local.

2. dale a crear un nuevo schema (nos servirá para desde ahí lanzar los script para que se cree la base de datos).

3. ahora en la carpeta script estarán el ddl_mysql y el dml_mysql.
   
	3.1. Ejecuta el ddl_mysql.
   
		3.1.1. Se te abrirá una nueva pestaña en sql workbench con el contenido.
		3.1.2. Copia el contenido entero.
		3.1.3. Haces doble clic en el schema que creamos antes y le damos a créate new SQL tab for executing queries.
		3.1.4. Dentro de esa nueva pagina pegas el contenido del ddl, seleccionas todo y le das al rayo para ejecutarlo.
		3.1.5. Le das a refrescar todo a la izquierda donde están los schemas. Veras q se ha creado uno nuevo que se llama crm.

	3.2. Ejecuta el dml_mysql.
   
		3.2.1. Se te abrirá una nueva pestaña en sql workbench con el contenido.
		3.2.2. Copia el contenido entero.
		3.2.3. Haces doble clic en el schema que creamos antes y le damos a créate new SQL tab for executing queries.
		3.2.4. Dentro de esa nueva pagina pegas el contenido del dml, seleccionas todo y le das al rayo para ejecutarlo.
		3.2.5. Le das a refrescar todo a la izquierda donde están los schemas. Para que se complete todas las tablas y mas.

5. En la aplicación en el apartado de src\main\java\com.pcmarketplace\util\DataBaseConection.java.
   
        4.1. Cambia la linea "private static final String URL = "jdbc:mysql://localhost:3306/crm";" si tienes otro puerto seleccionado.
        4.2. Cambia la linea "private static final String USER = "root";" y pon el nombre que tu le pusistes en sql.
        4.3. Cambia la linea "private static final String PASSWORD = "la_contraseña_MySQL";" y entre las comillas pon la contraseña que tengas en MySQL WorkBench.

7. Despues de haber hecho todo, abre el archivo Main.java.

Extra. Si te da error a la hora de querer ver el contenido de las tablas (dml) entonces haz lo siguiente.

        Extra.1. Dale clic derecho a pom.xml.
        Extra.2. Dale a donde pone Maven.
        Extra.3. Y le das a Sync Proyect arriba del todo para refrescar los cambios.

Una vez hecho esto, se podra ver el contenido de las tablas:
    Ej:
        Menu principal selecciona clientes
        Menu de clientes selecciona Listar Cliente para ver tocos los clientes que hay.
        Te deberian de aparecer todos, incluso los que has creado.

---

### Abrir la aplicación Web

README LENGUAJE DE MARCAS

REQUISITOS PREVIOS

    - Navegador web moderno (Chrome, Firefox, Edge o similar)
    - No se necesita servidor ni instalación adicional

PASOS PARA ABRIR EL PROYECTO

1. Descarga o clona el repositorio en tu equipo.

2. Navega hasta la carpeta lenguaje_de_marcas dentro del proyecto.

3. Abre el archivo index.html directamente en tu navegador haciendo doble clic sobre él.

    3.1. Se abrirá el dashboard principal con las estadísticas del CRM.
    3.2. Desde el menú de navegación puedes acceder al resto de secciones.

4. Si quieres ver una sección concreta puedes abrir directamente su archivo HTML.

    Ej:
        clientes.html   → gestión de clientes
        productos.html  → gestión del catálogo de productos
        usuarios.html   → gestión del equipo comercial
        ventas.html     → registro y consulta de ventas

ESTRUCTURA DEL PROYECTO

    lenguaje_de_marcas/
    ├── index.html          → Dashboard con estadísticas, últimas ventas y bajo stock
    ├── clientes.html       → Vista de gestión de clientes
    ├── productos.html      → Vista de gestión de productos
    ├── usuarios.html       → Vista de gestión del equipo comercial
    ├── ventas.html         → Vista de registro y gestión de ventas
    └── assets/
        ├── css/
        │   └── main.css    → Estilos globales del proyecto
        └── js/
            ├── models.js   → Clases del modelo de datos (Cliente, Producto, Usuario, Venta, DetalleVenta)
            ├── storage.js  → Claves de SessionStorage y datos iniciales de ejemplo
            ├── app.js      → Lógica del dashboard principal
            ├── clientes.js → CRUD completo de clientes
            ├── productos.js→ CRUD completo de productos con badge de stock
            ├── usuarios.js → CRUD completo de usuarios y roles
            └── ventas.js   → CRUD de ventas con control y descuento automático de stock

FUNCIONAMIENTO DE LOS DATOS

    - Los datos se guardan en el SessionStorage del navegador.
    - La primera vez que abres la aplicación se cargan datos de ejemplo automáticamente.
    - Los datos se mantienen mientras la pestaña esté abierta.
    - Al cerrar el navegador o la pestaña los datos se reinician al estado inicial.

FUNCIONALIDADES POR SECCIÓN

    1. Dashboard (index.html)
        - Muestra el total de ingresos registrados.
        - Indica el número de ventas completadas sobre el total.
        - Muestra cuántos clientes hay en la base comercial.
        - Lista los productos con stock igual o inferior a 5 unidades.
        - Muestra una tabla con las últimas ventas registradas.

    2. Clientes (clientes.html)
        - Crear, editar y eliminar clientes.
        - Campos: nombre, email, teléfono y dirección.
        - Buscador en tiempo real por nombre, email, teléfono o dirección.

    3. Productos (productos.html)
        - Crear, editar y eliminar productos del catálogo.
        - Campos: nombre, categoría, precio y stock.
        - Badge visual que indica si el stock es bajo (5 unidades o menos).
        - Buscador en tiempo real por nombre o categoría.

    4. Usuarios (usuarios.html)
        - Crear, editar y eliminar miembros del equipo comercial.
        - Campos: nombre, email y rol.
        - Buscador en tiempo real por nombre, email o rol.

    5. Ventas (ventas.html)
        - Registrar nuevas ventas seleccionando cliente, comercial, producto y cantidad.
        - Calcula el total automáticamente según el producto y la cantidad seleccionada.
        - Descuenta el stock del producto al registrar una venta.
        - Devuelve el stock al eliminar o cancelar una venta.
        - Buscador en tiempo real por cliente, comercial, producto, estado o fecha.

### Ejecutar los scripts de Base de Datos Oracle

README BASE DE DATOS

REQUISITOS PREVIOS

- Oracle Database 11g o superior instalado
- SQL*Plus o SQL Developer instalado

PASOS PARA CONFIGURAR EL ENTORNO

1. Abre SQL Developer y conéctate a tu instancia de Oracle con tu usuario y contraseña.

2. En la carpeta base_de_datos estarán los siguientes scripts:

   - ddl_oracle.sql  -> Crea las tablas, secuencias y triggers
   - dml_plsql.sql  -> Inserta, modifica y elimina registros usando bloques PL/SQL
   - cursores.sql  -> 5 consultas con cursores por cada tabla
   - procedimientos.sql  -> 2 procedimientos y 2 funciones por cada tabla

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
├── ddl_oracle.sql  -> Tablas, secuencias y triggers (Oracle)
├── dml_plsql.sql  -> CRUD completo en bloques PL/SQL
├── cursores.sql  -> 5 consultas con cursores por tabla
└── procedimientos.sql  -> 2 procedimientos y 2 funciones por tabla

TABLAS DE LA BASE DE DATOS

- CLIENTES  -> Almacena los clientes del CRM
- USUARIOS  -> Comerciales y administradores del sistema
- PRODUCTOS  -> Catálogo de productos disponibles
- VENTAS  -> Registro de ventas realizadas
- DETALLE_VENTA -> Líneas de producto de cada venta (tabla intermedia)

RELACIONES

- CLIENTES  -> VENTAS  (1:N)
- USUARIOS  -> VENTAS  (1:N)
- VENTAS  -> DETALLE_VENTA (1:N)
- PRODUCTOS -> DETALLE_VENTA (1:N)
- VENTAS  <-> PRODUCTOS  (N:M mediante DETALLE_VENTA)

