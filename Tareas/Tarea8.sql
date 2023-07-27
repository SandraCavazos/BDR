USE gas_trans_db

DROP VIEW IF EXISTS customersum;

CREATE VIEW customersum AS
	SELECT DISTINCT a.CustomerID AS CustomerID, a.Segment AS Segment, COUNT(TransactionID) AS Frequency, SUM(Price) AS Price
	FROM customers a
	JOIN transactions_1k b
	ON a.CustomerID = b.CustomerID	
	GROUP BY CustomerID
	ORDER BY Frequency DESC
;
-- clients with transactions, segment, count of transactions and total price
select * from customersum;


DROP VIEW IF EXISTS countrysum;

CREATE VIEW countrysum AS
	SELECT a.Country,a.GasStationID, a.ChainID, a.Segment, SUM(Amount) AS Amount
	FROM gasstations a
	LEFT JOIN transactions_1k b
	ON a.GasStationID = b.GasStationID	
	GROUP BY a.Country, a.GasStationID
	ORDER BY a.Country
;
-- country, gasstation, chain, segment and total amount if exists

select * from countrysum;



DROP VIEW IF EXISTS countrysum_trans;

CREATE VIEW countrysum_trans AS
	SELECT a.Country,a.GasStationID, a.ChainID, a.Segment, SUM(Amount) AS Amount
	FROM gasstations a
	RIGHT JOIN transactions_1k b
	ON a.GasStationID = b.GasStationID	
	GROUP BY a.Country, a.GasStationID
	ORDER BY a.Country
;
-- country, gasstation, chain, segment and total amount of those countries where transactions were made
select * from countrysum_trans;

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

select * from subconsulta;


-- trigger

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

select * from tra	nsactions_1k;
select * from products;
select * from gasstations;

