/*============================================================================
  Summary:  Demonstrates the Read Uncommitted Isolation Level
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

BEGIN TRANSACTION
UPDATE Person.Person
SET Title = 'Mr'
WHERE BusinessEntityID = 1

SELECT * FROM Person.Person
WHERE BusinessEntityID = 1

-- Execute the query from Session 2...

ROLLBACK TRANSACTION