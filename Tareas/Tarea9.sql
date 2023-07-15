--  Stored precedure: Regresión lineal

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

    -- calculate  intercept
    SET intercept = (sum_y - slope * sum_x) / n;

    -- results
    SELECT slope AS 'Regression Coefficient (slope)', intercept AS 'Intercept';

END//

DELIMITER ;


-- Stored precedure: Array

DELIMITER //

CREATE PROCEDURE sparray_function(length INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE arrat_function VARCHAR(255) DEFAULT '';
    
    WHILE i < length DO
        SET arrat_function = CONCAT(arrat_function, FLOOR(RAND() * 100) + 1, ',');
        SET i = i + 1;
    END WHILE;
    
    -- trim comma
    SET arrat_function = TRIM(TRAILING ',' FROM arrat_function);
    
    -- result
    SELECT arrat_function AS 'Random Array';
    
END//

DELIMITER ;
