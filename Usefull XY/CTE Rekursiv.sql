use Northwind;
select * from employees

;With AngCTE (employeeid, lastname, reportsto, Ebene)
as
(Select employeeid, lastname, reportsto , 0 as Ebene
	FROM Employees where reportsto is null

UNION ALL

select e.employeeid, e.lastname,e.reportsto, ANGCTE.Ebene +1
	FROM Employees e 
	inner join AngCTE
	ON angcte.employeeid=e.reportsto )
Select * from angcte order by reportsto 