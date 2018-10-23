USE AdventureWorks;
GO

-- Enable snapshot isolation on the database.
ALTER DATABASE AdventureWorks
    SET ALLOW_SNAPSHOT_ISOLATION ON;
GO

-- Start a snapshot transaction
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
GO

BEGIN TRANSACTION;
    -- This SELECT statement will return
    -- 48 vacation hours for the employee.
    SELECT EmployeeID, VacationHours
        FROM HumanResources.Employee
        WHERE EmployeeID = 4;

-------------------------2------------------------------------
    -- Reissue the SELECT statement - this shows
    -- the employee having 48 vacation hours.  The
    -- snapshot transaction is still reading data from
    -- the versioned row.
SELECT EmployeeID, VacationHours
        FROM HumanResources.Employee
        WHERE EmployeeID = 4;
-------------------------3------------------------------------
    -- Reissue the SELECT statement - this still 
    -- shows the employee having 48 vacation hours
    -- even after the other transaction has committed
    -- the data modification.
SELECT EmployeeID, VacationHours
        FROM HumanResources.Employee
        WHERE EmployeeID = 4;

    -- Because the data has been modified outside of the
    -- snapshot transaction, any further data changes to 
    -- that data by the snapshot transaction will cause 
    -- the snapshot transaction to fail. This statement 
    -- will generate a 3960 error and the transaction will 
    -- terminate.
    UPDATE HumanResources.Employee
        SET SickLeaveHours = SickLeaveHours - 8
        WHERE EmployeeID = 4;

-- Undo the changes to the database from session 1. 
-- This will not undo the change from session 2.
ROLLBACK TRANSACTION
GO