DBCC LOG([northwind], 2)

select * from fn_dblog(NULL,NULL)


checkpoint

Begin tran
insert into ma.personal values (12)
Commit 
