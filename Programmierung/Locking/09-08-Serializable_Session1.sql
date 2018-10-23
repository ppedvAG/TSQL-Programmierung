use Northwind;
GO
--alle Phantomreads werden dadruch vermieden, dass durch die starke Isolierung
--TX nacheinander ausgeführt werden
--


SET TRANSACTION ISOLATION LEVEL Repeatable Read
GO

--

Begin Transaction

SELECT * FROM customers

GO

Commit
Rollback
