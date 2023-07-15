# **Tarea 9**

Se crearon dos procedimientos almacenados los cuales están en el archivo de [Tarea9.sql](https://github.com/SandraCavazos/BDR/blob/master/Tareas/Tarea9.sql).

## *Creación regresiòn lineal Stored Procedure*

En este procedimiento se declaran las variables para almacenar valores intermedios y los coeficientes de regresión. Se utilizan instrucciones SELECT con funciones de agregación para calcular las sumas necesarias en el cálculo de la regresión. Por último, utiliza los valores calculados para determinar la pendiente (coeficiente de regresión) y el intercepto de la línea de regresión lineal.

```sql
DELIMITER //

CREATE PROCEDURE RegressionLineal()
BEGIN
    DECLARE n INT;
    DECLARE sum_x DECIMAL(10, 2);
    DECLARE sum_y DECIMAL(10, 2);
    DECLARE sum_xy DECIMAL(10, 2);
    DECLARE sum_x_squared DECIMAL(10, 2);
    DECLARE slope DECIMAL(10, 2);
    DECLARE intercept DECIMAL(10, 2);

    -- count rows
    SELECT COUNT(*) INTO n FROM transactions_1k;

    -- calculate the sum
    SELECT SUM(Price), SUM(Consumption), SUM(Price * Consumption), SUM(Price * Price)
    INTO sum_x, sum_y, sum_xy, sum_x_squared
    FROM transactions_1k;

    -- calculate  slope
    SET slope = (n * sum_xy - sum_x * sum_y) / (n * sum_x_squared - sum_x * sum_x);

    -- calculate intercept
    SET intercept = (sum_y - slope * sum_x) / n;

    -- results
    SELECT slope AS 'Regression Coefficient (slope)', intercept AS 'Intercept';

END//

DELIMITER ;
```

## *Creación ARRAY Stored Procedure*

Dentro del procedimiento se declaran dos variables: i para llevar la cuenta de la iteración actual y array_function para almacenar la matriz generada. Se inicializa i con 0 y array_function como una cadena vacía.

Se utiliza un bucle WHILE que genere números aleatorios entre 1 y 100 mediante la función RAND() y los concatena con un separador de comas en la variable array_function. El bucle continúa hasta que i alcanza la longitud especificada.

Una vez finalizado el bucle, se elimina la coma final de la matriz aleatoria utilizando las funciones TRIM() y TRAILING.


```sql
DELIMITER //

CREATE PROCEDURE sparray_function(length INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE array_function VARCHAR(255) DEFAULT '';
    
    WHILE i < length DO
        SET array_function = CONCAT(array_function, FLOOR(RAND() * 100) + 1, ',');
        SET i = i + 1;
    END WHILE;
    
    -- trim comma
    SET array_function = TRIM(TRAILING ',' FROM array_function);
    
    -- result
    SELECT array_function AS 'Random Array';
    
END//

DELIMITER ;
```