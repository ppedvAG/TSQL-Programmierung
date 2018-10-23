create function funkname (parameter)
returns table
as
return (select ..)

create function ftable1 (@par1 int)
returns table
as
return (select * from northwind.dbo.orders where orderid = @par1)

select * from dbo.ftable1 (10248)

