-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschr�nkungen verwendet oder ver�ndert werden.
-- Jedoch wird keine Garantie �bernommen, das eine Funktionsf�higkeit mit aktuellen und 
-- zuk�nftigen API-Versionen besteht. Der Autor �bernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgef�hrt wird.
-- F�r Anregungen und Fragen stehe ich jedoch gerne zur Verf�gung.
-- Thorsten Kansy, www.dotnetconsulting.eu


-- Dummy Abfrage
SELECT * FROM sys.sysobjects o1
CROSS JOIN sys.sysobjects o2
CROSS JOIN sys.sysobjects o3;


-- Aktivierung ohne SSMS
SET STATISTICS XML ON;
-- oder
SET STATISTICS PROFILE ON;
-- oder
-- Warnung!!! 30% oder mehr Performanceverlust
CREATE EVENT SESSION [query_post_execution_showplan_Test]
ON SERVER
ADD EVENT sqlserver.query_post_execution_showplan(
WHERE ([duration]=(5000000)));
GO

