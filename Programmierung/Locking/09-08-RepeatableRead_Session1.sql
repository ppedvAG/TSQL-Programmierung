use Northwind;
GO
--Lesen hindert schreiben.
--Gelesene Daten k�nnen nicht ver�ndert werden
--aber es  k�nnen aber neue eingef�gt werden
--gelesene Daten m�ssen allerdings nicht konsistent sein
--beim wiederholten Lesen k�nnen neue DS erscheinen...


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
