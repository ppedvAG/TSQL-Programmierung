--Fehlerbahndlung

--Fehler k�nnen passieren, aber was! soll passieren..
--rote Meldung oder TSQL Code

--begin try
--Code ausf�hren
--catc


use Northwind;
GO


Begin Tran
insert into customers (customerid, companyname)
	values	('ppedv', 'ppedv ag');

IF @@ERROR <> 0
	BEGIN 
		ROLLBACK TRAN	
		RAISERROR ('Fehler beim Einf�gen!', -- Message text.  
               16, -- Severity.  
               1 -- State.  
               );  
	END

Update customers set companyname = companyname +'XY'
	where customerid = 'ALFKI'

IF @@ERROR <> 0
	BEGIN
		Rollback tran
		RAISERROR ('Fehler beim Aktualisieren', -- Message text.  
               16, -- Severity.  
               1 -- State.  
               );  
	END
GOTO hell
Commit tran
hell: