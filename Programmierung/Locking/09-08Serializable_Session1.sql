use Northwind;
GO
--Lesen hindert schreiben.
--Gelesene Daten können nicht verändert werden
--aber es vs repeatableread auch keine neuen eingefügt werden
--gelesene Daten sind konsistent
--


SET TRANSACTION ISOLATION LEVEL Serializable
GO

--

Begin Transaction

SELECT * FROM customers

--Session2
Select * from customers -- neuer Datensatz wird gelesen

GO

Commit
Rollback


--cleanup
delete from customers where customerid = 'ppedv'
