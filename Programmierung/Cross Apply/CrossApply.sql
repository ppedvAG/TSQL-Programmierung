select * from [order details] cross apply dbo.frsumme(orderid)

create function fAng(@angid int) returns 
table -- (angíd int, lastname varchar(50))
as
return
select employeeid, lastname from employees where employeeid = @angid

select * from orders cross apply dbo.fang(employeeid)