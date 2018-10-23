-- Disclaimer
-- Dieser Quellecode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschr�nkungen verwendet oder ver�ndert werden.
-- Jedoch wird keine Garantie �bernommen, das eine Funktionsf�higkeit mit aktuellen und 
-- zuk�nftigen API-Versionen besteht. Der Autor �bernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgef�hrt wird.
-- F�r Anregungen und Fragen stehe ich jedoch gerne zur Verf�gung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- Datenbank anlegen und wechseln
USE [AdventureWorks2014];

-- Query Store einschalten
ALTER DATABASE [AdventureWorks2014] SET QUERY_STORE = ON;

-- Test Abfragen
SELECT * FROM [Sales].[vSalesPerson];
SELECT * FROM [HumanResources].[vEmployee];
SELECT * FROM [Sales].[vStoreWithContacts];


ALTER DATABASE [AdventureWorks2014] SET QUERY_STORE = OFF;



select * from sys.database_query_store_options;