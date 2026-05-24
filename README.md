README PROGRAMACION

REQUISITOS PREVIOS

    - Java JDK 17 o superior instalado
    - IntelliJ IDEA instalado
    - MySQL Server 8.0 instalado
    - MySQL Workbench instalado
    - Maven (viene incluido con IntelliJ)

PASOS PARA CONFIGURAR EL ENTORNO

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

4. En la aplicación en el apartado de src\main\java\com.pcmarketplace\util\DataBaseConection.java.
   
		4.1. Cambia la linea "private static final String URL = "jdbc:mysql://localhost:3306/crm";" si tienes otro puerto seleccionado.
		4.2. Cambia la linea "private static final String USER = "root";" y pon el nombre que tu le pusistes en sql.
		4.3. Cambia la linea "private static final String PASSWORD = "la_contraseña_MySQL";" y entre las comillas pon la contraseña que tengas en MySQL WorkBench.

5. Despues de haber hecho todo, abre el archivo Main.java.

Extra. Si te da error a la hora de querer ver el contenido de las tablas (dml) entonces haz lo siguiente.

    Extra.1. Dale clic derecho a pom.xml.
    Extra.2. Dale a donde pone Maven.
    Extra.3. Y le das a Sync Proyect arriba del todo para refrescar los cambios.

Una vez hecho esto, se podra ver el contenido de las tablas:
    Ej:
        Menu principal selecciona clientes
        Menu de clientes selecciona Listar Cliente para ver tocos los clientes que hay.
        Te deberian de aparecer todos, incluso los que has creado.
