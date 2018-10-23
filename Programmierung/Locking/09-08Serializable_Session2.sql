use Northwind;
GO

--select * from person.person

--geht...
insert into Customers
	 (CustomerID,CompanyName,city,country)
Values
	('ppedv','ppedv ag','Burghausen','Germany')

--geht nicht...
update customers set CompanyName=CompanyName+'x' where
customerid = 'ALFKI'

delete from customers where customerid = 'alfki'
---Session 1







GO

