use Northwind;

select
	EmployeeID
	, LastName
	, case
		when ReportsTo is null then 0
		else ReportsTo
	  end as ReportsTo
from employees 
order by ReportsTo

;With AngCTE (employeeid, lastname, reportsto, Ebene)
as
(
	Select 
		employeeid
		, lastname
		, reportsto
		, 0 as Ebene
	FROM Employees 
	where reportsto is null

	UNION ALL

	select 
		e.employeeid
		, e.lastname
		, e.reportsto
		, ANGCTE.Ebene + 1
	FROM Employees e 
		inner join AngCTE ON angcte.employeeid=e.reportsto
)

Select * from angcte order by reportsto




select
	EmployeeID
	, LastName
	, ReportsTo
from Employees

select
	ma.EmployeeID
	, ma.LastName
	, ma.ReportsTo
	, boss.LastName as Boss
from Employees boss
	right join Employees ma on ma.ReportsTo = boss.EmployeeID
