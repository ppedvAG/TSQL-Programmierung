use Northwind
GO

create proc KdSuche @kd varchar(10)
as
select * from customers where customerid like @kd +'%'
GO

Kdsuche '%'

KDSuche 'ALFKI'

select * from customers where customerid like 'ALFKI'