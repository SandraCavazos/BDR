# **Tarea 5**

## **Parte 1: Agregar datos de manera automática**

Como primer paso se requiere generar la información ficticia. Para esto, se hace uso de la herramienta [filldb.info](https://filldb.info/dummy), en la cual se proporciona el script creado en la tarea anterior excluyendo las instrucciones de inserción. Con esto, se genera la cantidad de datos indicada con la escructura deseada. Posteriormente se exporta la base de datos en formato .sql.

Una vez que se cuenta con la base de datos generada, en el script descargado se eliminan las instrucciones referentes a la creación de las tablas y se mantienen solo las de inserción. En la consola se ingresa el comando de inserción con la ruta del script: mysql -u sandracavazos -p gas_trans_db < "C:\Users\sandy\Documents\bd_gas.sql" y con esto se finaliza el proceso de agregar datos de manera automática.


## **Parte 2: Hallazgos, dificultades, recomendaciones o recursos relevantes**

1. En la tarea anterior se me presentó el problema de no poder conectarme a MySQL desde DBeaver. Para solucionarlo, descargué MySQL y creé mi usuario y contraseña para posteriormente utilizarlo en DBeaver y ajustar la configuración de Driver Properties, en específico cambiar el valor de "false" en allowPublicKeyRetrieval a "YES".

2. Incialmente, la terminal no reconocía el comando de mysql, por lo que tuve que agregar la ruta donde se descargó MySQL en el apartado de "Editar las variables de entorno del sistema".

3. Se generaba error en el comando de inserción desde la terminal indicando que había duplicados en llave primaria, esto fue porque la base de datos ya tenía cargada la información creada de la tarea anterior. Para solucionarlo, dejé las tablas vacías y volví a ejecutar el script.


## **Parte 3: Autoevaluación y evaluación de mis compañeros**

Al navegar por los repositorios de mis compañeros, pude observar un estilo distinto en la forma de trabajar y presentar las actividades entre cada uno de ellos. Se distingue la forma de presentar la información desde la estructura del readme y la elección de utilizar Markdown o PDF. A mi parecer, se refleja el interés y tiempo invertido, resultando en un trabajo de gran nivel.

Por mi parte, considero que mis actividades también logran reflejar el tiempo y dedicación invertido, logrando el objetivo de las tareas y manteniendo una buena presentación y orden. Considero que al igual que mis compañeros, mi trabajo es de gran nivel, por lo que tanto a ellos como a mí nos atribuiría una calificación de 10.