
USE northwind
GO
-- Creating Test Table
CREATE TABLE Product(Cust VARCHAR(25), Product VARCHAR(20), QTY INT)
GO
-- Inserting Data into Table
INSERT INTO Product(Cust, Product, QTY)
VALUES('KATE','VEG',2)
INSERT INTO Product(Cust, Product, QTY)
VALUES('KATE','SODA',6)
INSERT INTO Product(Cust, Product, QTY)
VALUES('KATE','MILK',1)
INSERT INTO Product(Cust, Product, QTY)
VALUES('KATE','BEER',12)
INSERT INTO Product(Cust, Product, QTY)
VALUES('FRED','MILK',3)
INSERT INTO Product(Cust, Product, QTY)
VALUES('FRED','BEER',24)
INSERT INTO Product(Cust, Product, QTY)
VALUES('KATE','VEG',3)
GO
-- Selecting and checking entires in table
SELECT *
FROM Product
GO
-- Pivot Table ordered by PRODUCT
SELECT PRODUCT, FRED, KATE
FROM (
SELECT CUST, PRODUCT, QTY
FROM Product) up
PIVOT (SUM(QTY) FOR CUST IN (FRED, KATE)) AS pvt
ORDER BY PRODUCT
GO
-- Pivot Table ordered by CUST
SELECT CUST, VEG, SODA, MILK, BEER, CHIPS
FROM (
SELECT CUST, PRODUCT, QTY
FROM Product) up
PIVOT (SUM(QTY) FOR PRODUCT IN (VEG, SODA, MILK, BEER, CHIPS)) AS pvt
ORDER BY CUST
GO
-- Unpivot Table ordered by CUST
SELECT CUST, PRODUCT, QTY
FROM
(
SELECT CUST, VEG, SODA, MILK, BEER, CHIPS
FROM (
SELECT CUST, PRODUCT, QTY
FROM Product) up
PIVOT
( SUM(QTY) FOR PRODUCT IN (VEG, SODA, MILK, BEER, CHIPS)) AS pvt) p
UNPIVOT
(QTY FOR PRODUCT IN (VEG, SODA, MILK, BEER, CHIPS)
) AS Unpvt
GO
-- Clean up database
DROP TABLE Product
GO


select * from product

select CUST, VEG, Milk
	from (select * from product) p
	Pivot
	( SUM(QTY) for product in (VEG, MILK)) pv
Order by CUST


SELECT Spalten des (Select Pivtotabelle) pt --Anzeige der Spaltenköpfe
PIVOT
(AGG(Spalte der Tabelle) for zupivotierende Werte in (Wert, wert2) pv2
Order by Spalte aus PT





SELECT        Customers.CompanyName, [Order Details].Quantity, Products.ProductName
INTO PIVOTTAB
FROM            Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID



select CUST,Tofu, [Queso Cabrales] from (select companyname as CUST, productname, quantity from  Pivottab) PT
PIVOT
(sum(quantity) for Productname in (Tofu, [Queso Cabrales])) pv2
 order by CUST

 
select CUST, VEG, Milk from (select * from product) p
Pivot
	( SUM(QTY) for product in (VEG, MILK)) pv
Order by CUST

select * from product

