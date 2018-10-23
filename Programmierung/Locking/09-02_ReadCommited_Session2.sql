/*============================================================================
  Summary:  Demonstrates the Read Committed Isolation Level
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
-- Session 2
-- =========
USE AdventureWorks2014
GO

-- We don't have to specify the READ COMMITTED isolation level, because its the default isolation level
SELECT * FROM Person.Person
WHERE BusinessEntityID = 1

		-->> wartet & wartet & wartet ...
GO