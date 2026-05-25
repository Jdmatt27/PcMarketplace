# PcMarketplace - Sistema CRM

Aplicacion de gestion para una tienda de componentes de PC. Permite administrar clientes, usuarios, productos y ventas desde la consola.

## Requisitos previos

- Java JDK 17 o superior
- IntelliJ IDEA
- MySQL Server 8.0
- MySQL Workbench
- Maven (incluido en IntelliJ IDEA)

## Configurar la base de datos

1. Abre MySQL Workbench y conectate a tu servidor local.
2. Crea un nuevo schema.
3. Ve a la carpeta `src/main/java/com/Scripts/`:
   - Abre `ddl_mysql.sql`, copia el contenido y pegalo en una nueva pestaña de consulta sobre el schema que creaste. Ejecutalo con el icono del rayo. Se creara el schema `crm` con todas las tablas.
   - Haz lo mismo con `dml_mysql.sql` para cargar los datos de prueba.

## Configurar la conexion a la base de datos

Abre `src/main/java/com/pcmarketplace/util/DataBaseConection.java` y ajusta estas tres lineas con tus datos de MySQL:

```java
private static final String URL = "jdbc:mysql://localhost:3306/crm"; // cambia el puerto si es necesario
private static final String USER = "root";                           // tu usuario de MySQL
private static final String PASSWORD = "tu_contraseña";             // tu contraseña de MySQL
```

## Ejecutar la aplicacion

1. Abre el proyecto en IntelliJ IDEA.
2. Si Maven da algun error, haz clic derecho en `pom.xml` → Maven → Sync Project.
3. Ejecuta la clase `Main.java`.

## Uso

Al ejecutar la aplicacion aparece el menu principal:

```
=============================
       MENU PRINCIPAL
=============================
1. Clientes
2. Usuarios
3. Productos
4. Ventas
5. Detalles de venta
0. Salir
=============================
```

Desde cada opcion puedes listar, crear, actualizar y eliminar registros.

## Estructura del proyecto

```
src/
 └── main/java/com/
      ├── Scripts/              → Scripts SQL (DDL y DML)
      └── pcmarketplace/
           ├── models/          → Entidades del dominio (Customer, Product, Sale...)
           ├── repositories/    → Acceso a datos (interfaces e implementaciones JDBC)
           ├── services/        → Logica de negocio
           ├── controllers/     → Controladores de cada entidad
           ├── util/            → Conexion a BD y exportacion a CSV
           ├── Menu.java        → Menu interactivo por consola
           └── Main.java        → Punto de entrada de la aplicacion
```

## Autores

- Javier — javierclementejr@gmail.com
- Juanda — jdavidmatt27@gmail.com
