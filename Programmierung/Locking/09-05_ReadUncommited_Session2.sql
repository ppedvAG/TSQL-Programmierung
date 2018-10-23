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
-- Session 2
-- =========
USE AdventureWorks2014
GO

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
GO

SELECT * FROM Person.Person
WHERE BusinessEntityID = 1
GO