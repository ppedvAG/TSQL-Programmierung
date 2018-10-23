use Northwind;
GO
--Lesen hindert schreiben.
--Gelesene Daten können nicht verändert werden
--aber es  können aber neue eingefügt werden
--gelesene Daten müssen allerdings nicht konsistent sein
--beim wiederholten Lesen können neue DS erscheinen...


SET TRANSACTION ISOLATION LEVEL Repeatable Read
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
