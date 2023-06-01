drop database if exists gas_trans_db;

create database gas_trans_db;

use gas_trans_db;

drop table if exists products;

create table products (
  ProductID INT primary key,
  Description VARCHAR(255)
);

drop table if exists gasstations;

create table gasstations (
  GasStationID INT primary key,
  ChainID INT,
  Country VARCHAR(3),
  Segment VARCHAR(3)
);

drop table if exists customers;

create table customers (
  CustomerID INT primary key,
  Segment VARCHAR(3),
  Currency VARCHAR(3)
);

drop table if exists yearmonth;

create table yearmonth (
  CustomerID INT,
  Date_t DATE,
  Consumption DECIMAL,
  foreign key (CustomerID) REFERENCES customers(CustomerID)
);

drop table if exists transactions_1k;

 
create table transactions_1k (
  TransactionID INT primary key,
  Date_t DATE,
  Time_t TIME,
  CustomerID INT,
  CardID INT,
  GasStationID INT,
  ProductID INT,
  Amount INT,
  Price DECIMAL,
  foreign key (CustomerID) REFERENCES customers(CustomerID),
  foreign key (GasStationID) REFERENCES gasstations(GasStationID),
  foreign key (ProductID) REFERENCES products(ProductID)
);


  
 INSERT INTO products (ProductID, Description)
VALUES
  (1, 'Product 1'),
  (2, 'Product 2'),
  (3, 'Product 3'),
  (4, 'Product 4'),
  (5, 'Product 5'),
  (6, 'Product 6'),
  (7, 'Product 7'),
  (8, 'Product 8'),
  (9, 'Product 9'),
  (10, 'Product 10');
  
 INSERT INTO gasstations (GasStationID, ChainID, Country, Segment)
VALUES
  (1, 1, 'USA', 'S1'),
  (2, 1, 'USA', 'S2'),
  (3, 2, 'UK', 'S1'),
  (4, 2, 'UK', 'S2'),
  (5, 3, 'FR', 'S1'),
  (6, 3, 'FR', 'S2'),
  (7, 4, 'GER', 'S1'),
  (8, 4, 'GER', 'S2'),
  (9, 5, 'CAN', 'S1'),
  (10, 5, 'CAN', 'S2');
  
  
 INSERT INTO customers (CustomerID, Segment, Currency)
VALUES
  (1, 'S1', 'USD'),
  (2, 'S2', 'EUR'),
  (3, 'S1', 'USD'),
  (4, 'S2', 'GBP'),
  (5, 'S1', 'EUR'),
  (6, 'S2', 'GBP'),
  (7, 'S1', 'USD'),
  (8, 'S2', 'EUR'),
  (9, 'S1', 'GBP'),
  (10, 'S2', 'EUR');
  
 INSERT INTO yearmonth (CustomerID, Date_t, Consumption)
VALUES
  (1, '2023-01-01', 100.5),
  (2, '2023-01-02', 75.2),
  (3, '2023-01-03', 150.8),
  (4, '2023-01-04', 120.3),
  (5, '2023-01-05', 90.6),
  (1, '2023-02-01', 80.4),
  (2, '2023-02-02', 110.2),
  (3, '2023-02-03', 95.7),
  (4, '2023-02-04', 70.9),
  (5, '2023-02-05', 105.1);
  
 INSERT INTO transactions_1k (TransactionID, Date_t, Time_t, CustomerID, CardID, GasStationID, ProductID, Amount, Price)
VALUES
  (1, '2023-01-01', '08:30:00', 1, 1, 1, 1, 2, 10.99),
  (2, '2023-01-02', '12:15:00', 2, 2, 1, 2, 3, 15.75),
  (3, '2023-01-03', '16:45:00', 1, 3, 2, 3, 1, 5.99),
  (4, '2023-01-04', '10:00:00', 3, 4, 3, 1, 4, 8.50),
  (5, '2023-01-05', '14:30:00', 2, 5, 2, 1, 2, 10.99),
  (6, '2023-01-06', '09:45:00', 1, 6, 3, 3, 3, 15.75),
  (7, '2023-01-07', '13:20:00', 3, 7, 1, 2, 1, 5.99),
  (8, '2023-01-08', '11:10:00', 2, 8, 2, 1, 2, 10.99),
  (9, '2023-01-09', '17:00:00', 1, 9, 3, 3, 4, 8.50),
  (10, '2023-01-10', '15:45:00', 3, 10, 1, 2, 3, 15.75);
  
-- visualize data
 select *
 from transactions_1k
 
 select *
 from customers
 
 select *
 from yearmonth 
 
 select *
 from gasstations 
 
 select *
 from products
 