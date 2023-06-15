# **Tarea 6**

## **Funciones de agregación**

1. Conteo de frecuencias o media

Se busca encontrar el precio promedio de las transacciones realizadas después de las 12:00:00 del día, para ello se formula la siguiente consulta:

´´´ sql
mysql> SELECT AVG(Price) FROM transactions_1k WHERE Time_t>'12:00:00';

+---------------+
| AVG(Price)    |
+---------------+
| 25463899.3696 |
+---------------+

´´´

2. Mínimos o máximos

Se desea encontrar la cantidad máxima comprada de toda la base de transacciones, para lo cual se formula la siguiente consulta:

´´´ sql
mysql> SELECT MAX(Amount) FROM transactions_1k;

+-------------+
| MAX(Amount) |
+-------------+
|         984 |
+-------------+

´´´

3. Cuartil distinto a la mediana

Se requiere encontrar el tercer cuartil entre los precios en las transacciones, se propone lo siguiente:

´´´ sql
mysql> set @total:=(select count(Price) from transactions_1k);
Query OK, 0 rows affected (0.01 sec)

mysql> SELECT 3*(@total+1)/4 AS "Posición";
+----------+
| Posición |
+----------+
|  75.7500 |
+----------+
1 row in set (0.00 sec)

mysql> SELECT Price AS "Tercer Cuartil" FROM transactions_1k ORDER BY Price ASC LIMIT 76,1;
+----------------+
| Tercer Cuartil |
+----------------+
|        6415171 |
+----------------+
1 row in set (0.00 sec)

´´´
4. Moda

Se quiere conocer cuál es el país con más gasolineras.

´´´ sql
mysql> select Country, count(*) as "Frecuencia" from gasstations group by Country having Frecuencia=(select count(Country) as "Frecuencia" from gasstations group by Country order by Frecuencia desc limit 1);
+---------+------------+
| Country | Frecuencia |
+---------+------------+
| Aze     |          4 |
| Gua     |          4 |
+---------+------------+
2 rows in set (0.00 sec)

´´´
5. Hallazgos dificultades, implementación de soluciones encontradas en línea, etc.

El cálculo que más se me complicó fue el del cuartil. Quería encontrar una forma de hacer una sola consulta y que el resultado fuese el cuartil deseado, pero al final me auxilié de variables para lograr el objetivo. Busqué en internet posibles soluciones, pero hacían uso de otros recursos fuera de funciones de agregación, por lo cual generé una consulta propia.

En cuanto a hallazgos, explorando si podía encontrar la moda en una sola línea, identifiqué que es posible igualar un campo directamente a una selección, lo cuál me parece muy útil.