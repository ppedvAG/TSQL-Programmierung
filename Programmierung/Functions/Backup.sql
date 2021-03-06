--VOLLSTÄNDIGE --SICHERUNG
BACKUP DATABASE [WienDB] TO  DISK = N'C:\_STDINST\_Backup\WienDB.bak'
	 WITH NOFORMAT, NOINIT, 
	 NAME = N'WienDB-Vollständig Datenbank Sichern',
	 SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--TLOG
WAITFOR Delay '00:00:05'
BACKUP LOG [WienDB] TO  DISK = N'C:\_STDINST\_Backup\WienDB.bak'
	 WITH NOFORMAT, NOINIT,  NAME = N'WienDB-TLOG Sichern',
	 SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO 5

--DIFF
BACKUP DATABASE [WienDB] TO  DISK = N'C:\_STDINST\_Backup\WienDB.bak'
	 WITH  DIFFERENTIAL , NOFORMAT, NOINIT,
	   NAME = N'WienDB- DIFF Sichern', 
	   SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

select * into Customers from northwind.dbo.customers --10:20:55....10:21:05
