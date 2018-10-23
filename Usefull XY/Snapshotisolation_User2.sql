USE AdventureWorks;
GO

-- Start a transaction
BEGIN TRANSACTION;
    -- Subtract a vacation day from employee 4.
    -- Update is not blocked by session 1 since
    -- under snapshot isolation shared locks are
    -- not requested.
    UPDATE HumanResources.Employee
        SET VacationHours = VacationHours - 8
        WHERE EmployeeID = 4;

-- Verify that the employee now has 40 vacation hours.
    SELECT VacationHours
        FROM HumanResources.Employee
        WHERE EmployeeID = 4;

-----------------------2--------------------------------------
-- Commit the transaction; this commits the data
-- modification.
COMMIT TRANSACTION;
GO