
/*============================================================================
  Summary:  Demonstrates the Repeatable Read Isolation Level
------------------------------------------------------------------------------
  Written by Klaus Aschenbrenner, www.SQLpassion.at

  For more scripts and sample code, check out 
    http://www.SQLpassion.at

  THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF 
  ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED 
  TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
  PARTICULAR PURPOSE.
============================================================================*/

-- =========
-- Session 1
-- =========
USE AdventureWorks2014
GO

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
GO

-- Shared Locks are aquired as soon as we first access a resource and held until the end of the transaction
BEGIN TRANSACTION

-- The column "ModifiedDate" is not indexed, therefore SQL Server has to lock a lot more
SELECT * FROM Person.Person
WHERE ModifiedDate = '20120208'

-- Execute the script from the other session
-- ...

COMMIT TRANSACTION
GO