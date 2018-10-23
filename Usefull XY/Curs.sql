
declare @last as varchar(50)
declare  @first as varchar(50)


declare curs  cursor
SCROLL FOR 
Select lastname, firstname from employees

open curs
fetch first from curs into @last, @first
select @last, @first


close curs
deallocate curs