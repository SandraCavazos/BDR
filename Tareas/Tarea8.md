# **Tarea 8**

## *Creación de vistas, subconsulta y trigger*

Se crearon distintas vistas que también pueden ser vistas en el archivo [Tarea8.sql](https://github.com/SandraCavazos/BDR/blob/master/Tareas/Tarea8.sql).

### Join
Se crea una vista para ver los clientes que transaccionaron, el segmento al que pertenecen, la cantidad de transacciones que realizaron y el precio. De esta manera se puede consultar y analizar información correspondiente a la población de clientes que transaccionaron.

```sql
DROP VIEW IF EXISTS customersum;

CREATE VIEW customersum AS
	SELECT DISTINCT a.CustomerID AS CustomerID, a.Segment AS Segment, COUNT(TransactionID) AS Frequency, SUM(Price) AS Price
	FROM customers a
	JOIN transactions_1k b
	ON a.CustomerID = b.CustomerID	
	GROUP BY CustomerID
	ORDER BY Frequency DESC
;
```

### Left join
Se crea una vista donde se identifican los países y sus gasolineras y así como el monto transaccionado en caso de existir.

```sql
DROP VIEW IF EXISTS countrysum;

CREATE VIEW countrysum AS
	SELECT a.Country,a.GasStationID, a.ChainID, a.Segment, SUM(Amount) AS Amount
	FROM gasstations a
	LEFT JOIN transactions_1k b
	ON a.GasStationID = b.GasStationID	
	GROUP BY a.Country, a.GasStationID
	ORDER BY a.Country
;
```

### Right join
Para esta vista se obtienen las mismas columnas que en el left join, pero ahora conservando únicamente los países en en las que hubo transacciones. Esto puede facilitar el análisis de información al concentrar solo los países de interés.

```sql
DROP VIEW IF EXISTS countrysum_trans;

CREATE VIEW countrysum_trans AS
	SELECT a.Country,a.GasStationID, a.ChainID, a.Segment, SUM(Amount) AS Amount
	FROM gasstations a
	RIGHT JOIN transactions_1k b
	ON a.GasStationID = b.GasStationID	
	GROUP BY a.Country, a.GasStationID
	ORDER BY a.Country
;
```

### Subconsulta
Se realizó una subconsulta tal que se obtuvieran los clientes y su consumo de aquellos que hayan realizado transacciones por un monto mayor a 100 um.

```sql
DROP VIEW IF EXISTS subconsulta;

CREATE VIEW subconsulta AS
	SELECT a.CustomerID, SUM(c.Consumption) AS Consumption
	FROM customers a
	RIGHT JOIN (SELECT CustomerID 
				FROM transactions_1k
				WHERE Price > 100) b
		ON a.CustomerID = b.CustomerID
	LEFT JOIN yearmonth c
		ON a.CustomerID = c.CustomerID
	GROUP BY a.CustomerID

;
```

## Trigger

Este trigger se desencadena después de insertar, actualizar o eliminar una fila en la tabla "transactions_1k". Calculará el consumo total del cliente para el mes y año correspondiente y luego actualizará la tabla "yearmonth" con ese consumo. Si el consumo es cero, elimina el registro correspondiente en la tabla "yearmonth". Si ya existe una entrada para el cliente y el mes en la tabla "yearmonth", se actualizará el consumo existente. De esta manera se conservará consistencia entre la información de ambas tablas.

```sql
DROP TRIGGER IF EXISTS update_consumption;

DELIMITER //
CREATE TRIGGER update_consumption
AFTER INSERT, UPDATE, DELETE ON transactions_1k
FOR EACH ROW
BEGIN
    DECLARE total DECIMAL(10, 2);
    DECLARE transaction_month VARCHAR(3);

    -- get year and month of transaction
    SET transaction_month = DATE_FORMAT(NEW.Date_t, '%Y-%m');

    -- calculate total amount by client
    SELECT SUM(Amount) INTO total
    FROM transactions_1k
    WHERE Customer_ID = NEW.Customer_ID AND DATE_FORMAT(Date_t, '%Y-%m') = transaction_month;

    -- update table yearmonth with updated consumption
    IF total IS NULL THEN
        DELETE FROM yearmonth
        WHERE Customer_ID = NEW.Customer_ID AND Date_t = transaction_month;
    ELSE
        INSERT INTO yearmonth (Customer_ID, Date_t, Consumption)
        VALUES (NEW.Customer_ID, transaction_month, total)
        ON DUPLICATE KEY UPDATE Consumption = total;
    END IF;
END //
DELIMITER
```

