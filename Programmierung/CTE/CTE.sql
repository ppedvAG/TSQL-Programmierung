use Northwind;


--Chefsuche
SELECT ReportsTo, EmployeeID 
FROM Employees
WHERE ReportsTo IS NULL

UNION ALL

SELECT e.ReportsTo, e.EmployeeID --Ang mit Manager verknüpfen
FROM Employees e
INNER JOIN Employees mgr
ON e.ReportsTo = mgr.EmployeeID

--IN CTE Umbauen--


;WITH Manager (EmployeeID, ManagerID)
AS
(SELECT Employeeid, reportsto FROM employees)


SELECT e.Employeeid, ManagerID FROM Manager e
INNER JOIN dbo.Employees mgr ON e.EmployeeID=mgr.EmployeeID
ORDER BY e.ManagerID;




	     
with CTE(id,department, parent, Ebene)
as
(
select id,department, parent , 0 as Ebene from departments where parent is null
UNION ALL
select d.id,d.department, d.parent , Ebene +1 from departments d inner join cte on cte.id=d.parent
)
select * from cte order by ebene

select * from departments



with cte (lastname, employeeid, chef, Ebene)
as
(
select lastname, employeeid, reportsto as Chef , 0 as Ebene from employees
			where reportsto is null
UNION ALL

select e.lastname, e.employeeid, e.reportsto, ebene+1 from employees e inner join cte on cte.employeeid = e.reportsto
)
select cte.Lastname,e.lastname, chef, ebene  from cte left join employees e on e.employeeid =cte.chef


