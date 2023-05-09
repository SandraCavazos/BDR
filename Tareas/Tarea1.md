# **Tarea 1**

## **Parte 1: Elección de Base de datos**

<p align="justify">Tras la evaluación de diversas bases de datos, se elige el dataset CCS por Jan Motl ([db](https://relational.fit.cvut.cz/dataset/CCS)), encontrada en la página _Relational Dataset Repository_ y con fuente origen de github.com. Esta base de datos contiene datos transaccionales reales de una empresa de tarjetas de débito checa especializada en pagos en surtidores de gasolina.</p>

<p align="justify">Está compuesta por 6 tablas, las cuales suman un total de 29 columnas y 422,868 filas. Los tipos de dato pueden ser numéricos, cadenas o temporales, tal como se muestra a continuación:</p>


|  yearmonth| |
|----|----|
|CustomerID |› int|
|Date |› int|
|Consumption |› decimal|

|  customers| |
|----|----|
|CustomerID |› int|
|Segment |› varchar|
|Currency |› varchar|

|  transactions| |
|----|----|
|Date |› date|
|Time |› time|
|CustomerID |› int|
|CardID |› int|
|GasStationID |› int|
|ProductID |› int|
|Amount |› int|
|Price |› decimal|

|  gasstations| |
|----|----|
|GasStationID |› int|
|ChainID |› int|
|Country |› varchar|
|Segment |› varchar|

|  products| |
|----|----|
|ProductID |› int|
|Description |› varchar|

|  transactions_1k| |
|----|----|
|TransactionID|int|
|Date |› date|
|Time |› time|
|CustomerID |› int|
|CardID |› int|
|GasStationID |› int|
|ProductID |› int|
|Amount |› int|
|Price |› decimal|

<p align="justify">Como es posible observar, las tablas se pueden relacionar a través de los campos CustomerID, ProductID y GasStationID para analizar las transacciones y consumo en productos de los clientes. </p>

## **Parte 2: Investigación y Elección de SGBD**

### **Investigación.**

<p align="justify">Un Sistema Gestor de Base de Datos (SGBD o DBMS por sus siglas en inglés) es una herramienta a través de la cual se crean, gestionan y administran bases de datos para que el almacenamiento y consulta de información sea más eficiente.</p>

 Existen diversos SGBD, los cuales difieren en la forma en que se estructuran los datos, tal como se menciona a continuación ([1](https://universidadeuropea.com/blog/para-que-sirve-gestor-base-datos/#:~:text=Un%20sistema%20gestor%20de%20bases,en%20la%20base%20de%20datos)): 

◊ Modelo **relacional**: _Es el más popular y común. Los datos se estructuran en tablas con filas y columnas y se pueden crear diferentes relaciones entre ellas con claves comunes._ 
◊ Modelo **jerárquico**: _Los datos se organizan en relaciones padre-hijo siguiendo una estructura similar a la de un árbol._  
◊ Modelo de **red**: _La información se estructura en forma de red con relaciones complejas y se pueden seguir diferentes caminos para rastrear cada registro._  
◊ Modelo **orientado a objetos**: _No solo se tiene en cuenta la relación entre los registros de datos, sino también la herencia, tal que los objetos pueden transferir algunos de sus atributos a otros._  
◊ Modelo **orientado a documentos**: _Permite almacenar los registros en diferentes documentos._ </p> 

Entre los SGBD relacionales se encuentran los siguientes ([5](https://www.inesem.es/revistadigital/informatica-y-tics/los-gestores-de-bases-de-datos-mas-usados/)):

|    SGBD   |   DESCRIPCIÓN     |   PROS    |   CONTRAS     |
|-----------|-------------------|-----------|---------------|
|MySQL ([2](https://codigosql.top/ventajas-y-desventajas-de-mysql/))|Es un SGBD multihilo y multiusuario utilizado en la gran parte de las páginas web y el más usado en aplicaciones creadas como software libre.| (a) Facilidad de uso y gran rendimiento, (b) Facilidad para instalar y configurar, (c) Soporte multiplataforma, (d) Soporte SSL. | (a) La escalabilidad: poco eficiente con BD de grandes volúmenes que superan un determinado tamaño, (b) Limitaciones de seguridad, (c) Falta de soporte oficial. |
|MariaDB ([3](https://codigosql.top/mariadb/ventajas-desventaja/))|Es una derivación de MySQL con la mayoría de sus características, además de varias extensiones.| (a) Código abierto, (b) Compatible con MySQL, (c) Aumento de motores de almacenamiento, (d) Gran escalabilidad, (e) Seguridad y rapidez en transacciones, (f) Extensiones y nuevas características relacionadas con su aplicación para Bases de datos NoSQL. | (a) Pequeñas incompatibilidades en la migración de MariaDB y MySQL, (b) Pequeños atrasos en la liberación de versiones estables. |
|SQLite ([4](https://www.hostinger.mx/tutoriales/sqlite-vs-mysql-cual-es-la-diferencia))| Más que un SGBD como tal, es una biblioteca escrita en C que implementa un SGBD y que permite transacciones sin necesidad de un servidor ni configuraciones.| (a) Es _open source_, (b) Reúne los cuatro criterios ACID (Atomicidad, Consistencia, Aislamiento y Durabilidad) logrando gran estabilidad, (c) Gran portabilidad y rendimiento. | (a) La escalabilidad: no soporta bases de datos de gran volumen, (b) Carece de funciones de seguridad y administración de usuarios.|
|PostgreSQL| MEs un SGBD que combina relacional y orientado a objetos. Es libre, publicado bajo la licencia BSD.| (a) Control de Concurrencias multiversión (MVCC), (b) Flexibilidad en cuanto a lenguajes de programación, (c) Multiplataforma, (d) Escalabilidad, (e) Robustez, Eficiencia y Estabilidad. | (a) Lentitud para la administración de bases de datos pequeñas ya que está optimizado para gestionar grandes volúmenes de datos.|
|SQL Server| SGBD basado en el lenguaje Transact-SQL, capaz de poner a disposición de muchos usuarios grandes cantidades de datos de manera simultánea.| (a) Escalabilidad, estabilidad y seguridad, (b) Posibilidad de cancelar consultas, (c) Potente entorno gráfico de administración que permite utilizar comandos DDL y DML, (d) Permite trabajar en modo cliente-servidor, (e) Aunque es nativo para Windows puede utilizarse desde hace ya un tiempo en otras plataformas como Linux o Docker. | (a) Requiere planes de pago.|
|Oracle| El SGBD por excelencia para el mundo empresarial. | (a) Completo y robusto, (b) Soporte de transacciones, (c) Seguridad, (d) Estabilidad, (e) Escalabilidad, (f) Multiplataforma. | (a) Requiere planes de pago.|


### **Elección del SGBD para el curso.**

<p align="justify">Una vez analizadas las ventajas y desventajas de cada uno de los SGBD relacionales más utilizados, se prefiere trabajar con MySQL durante el curso ya que cuenta con las funcionalidades necesarias para cumplir el objetivo del curso. Es suficiente, fácil de instalar y configurar, además que para el curso no se requiere un sistema de alta potencia que consuma gran cantidad de memoria, pues el volumen de las bases de datos seleccionadas no es grande.</p>

#### **Descripción de MySQL.**

<p align="justify">MySQL es el SGBD relacional más extendido en la actualidad, con una doble licencia – es de código abierto pero también cuenta con una versión comercial gestionada por Oracle. Se ofrece bajo la GNU GPL pero desde la compra de Oracle se está orientando al ámbito empresarial y ya es posible adquirir una licencia para empresas que deseen incorporarlo en productos privativos. </p>

## Referencias.
Base de datos:
https://relational.fit.cvut.cz/dataset/CCS

Investigación:
1.	https://universidadeuropea.com/blog/para-que-sirve-gestor-base-datos/#:~:text=Un%20sistema%20gestor%20de%20bases,en%20la%20base%20de%20datos.
2.	https://codigosql.top/ventajas-y-desventajas-de-mysql/
3.	https://codigosql.top/mariadb/ventajas-desventaja/
4.	https://www.hostinger.mx/tutoriales/sqlite-vs-mysql-cual-es-la-diferencia
5.	https://www.inesem.es/revistadigital/informatica-y-tics/los-gestores-de-bases-de-datos-mas-usados/
