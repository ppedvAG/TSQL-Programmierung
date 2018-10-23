create database CursorDemo
GO

--##############################################################################################
--DECLARE statements - Declare variables used in the code block
--SET\SELECT statements - Initialize the variables to a specific value
--DECLARE CURSOR statement - Populate the cursor with values that will be evaluated
--NOTE - There are an equal number of variables in the DECLARE CURSOR FOR statement as there are in the SELECT statement.  This could be 1 or many variables and associated columns.
--OPEN statement - Open the cursor to begin data processing
--FETCH NEXT statements - Assign the specific values from the cursor to the variables
--NOTE - This logic is used for the initial population before the WHILE statement and then again during each loop in the process as a portion of the WHILE statement
--WHILE statement - Condition to begin and continue data processing
--BEGIN...END statement - Start and end of the code block
--NOTE - Based on the data processing multiple BEGIN...END statements can be used
--Data processing - In this example, this logic is to backup a database to a specific path and file name, but this could be just about any DML or administrative logic
--CLOSE statement - Releases the current data and associated locks, but permits the cursor to be re-opened
--DEALLOCATE statement - Destroys the cursor
--##############################################################################################



DECLARE @name VARCHAR(50) -- database name  
DECLARE @path VARCHAR(256) -- path for backup files  
DECLARE @fileName VARCHAR(256) -- filename for backup  
DECLARE @fileDate VARCHAR(20) -- used for file name 

SET @path = 'C:\_STDINST\_Backup'  

SELECT @fileDate = CONVERT(VARCHAR(20),GETDATE(),112) 

DECLARE db_cursor CURSOR FOR  
SELECT name 
FROM MASTER.dbo.sysdatabases 
WHERE name NOT IN ('master','model','msdb','tempdb')  

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @name   

WHILE @@FETCH_STATUS = 0   --Tech_STATUS
BEGIN   
       SET @fileName = @path + @name + '_' + @fileDate + '.BAK'  
       BACKUP DATABASE @name TO DISK = @fileName  

       FETCH NEXT FROM db_cursor INTO @name   
END   

CLOSE db_cursor   
DEALLOCATE db_cursor