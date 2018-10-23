use northwind;
GO
drop table Customers2
select * into Customers2 from customers;
GO
select * from customers2

Begin transaction T1
update customers2 set city = 'Y'
select * from customers2
select @@TRANCOUNT

Begin transaction M2 with MARK;
update customers2 set city ='Z'
select * from customers2
select @@TRANCOUNT
--ROLLBACK TRANSACTION M2
Commit Transaction M2

update customers2 set city =  'K'
select * from customers2
select @@TRANCOUNT
ROLLBACK TRANSACTION M2
Commit Transaction T1

rollback

