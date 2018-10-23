--CHOOSE ..isnull

select choose(2, 'Mo','di','mi','do','fr','sa','so')

select isnull(NULL,'unbekannt')

select city, IIF (city = 'Berlin', 'A', 'B') from customers


select datename(dw,getdate())

--NULL: 1+NULL = NULL 
--NULL kostet Platt je nach Datentyp

create table kochbuch
	(id int identity, Rezept varchar(50),
		Eis int sparse null,
		--nun statt 1000 Spalten 30000 Spalten

bit: 0,125bytes... 98% NULL für ROI
decimal: ... 42%
uniqueidentifier ..43%
--"text"... 60%










select CompanyName, country, 
	CASE 
		when country = 'UK' then 'EU'
		when country = 'Italy' then 'EU'
		ELSE 'EU Ausland'
	END as EULAND
 from customers

  
select CompanyName, country, 
	CASE 
		when country in ( 'UK', 'Italy', 'France') then 'EU'
		when country = 'UK' then 'GB'
		when country like '%sa%' then 'toller test'
		ELSE 'EU Ausland'
	END as EULAND
 from customers




--hohe Frachtkosten : C (500 oder mehr)
--niedrige sind ein A (unter 100)
--der rest B
select orderid,freight,
	 case 
		when freight<100 then 'A' 
		when freight>500 then 'C'
		else 'B'
	 end
from orders


select orderid, freight, 'A' from orders where freight < 100
UNION ALL
select orderid,freight, 'B' from orders where freight > 500
UNION ALL
select orderid,freight, 'C' from orders where freight between 100 and 500






