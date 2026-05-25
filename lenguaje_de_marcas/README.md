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
