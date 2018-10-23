--sperren beobachten

select * from sys.dm_tran_locks where resource_database_id=db_id('adventureworks2014')