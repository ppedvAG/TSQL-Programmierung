--select top 3 * from kundeumsatz

Select lastname, [1996], [1997], [1998] from
	(
	select	lastname
			, year(orderdate) as Jahr
			, Freight 
			from kundeumsatz
	) as KU
PIVOT 
	(
		sum(freight) for Jahr in ([1996], [1997], [1998])
	) as pv



--Umsatz pro Land und Kunde

select customerid, [UK],[USA], [Germany], [France]
from
(
	select 
	customerid,
	(unitprice*quantity) as PosSumme,
	Country as Land
	from kundeUmsatz
) as KU
PIVOT
(
	 sum(Possumme) for Land in ([UK],[USA], [Germany], [France])
) pv


--welche Kunden aus UK hatten KOntakt mit Robert King

select Kunde, 
		 case when [King]='King' then 'X' else '' end as [King]
		 ,case when [Suyama] = 'Suyama' then 'X' else '' end as [Suyama]
		
from
	(
	select	c.customerid as Kunde, lastname 
	from	customers c inner join orders o
						on c.customerid = o.customerid
						inner join employees e 
						on e.employeeid=o.employeeid
	where c.country = 'UK' --and e.lastname='King'
	) as KA
PIVOT
	(
		max(Lastname) 
		for lastname 
		in ([King],[Suyama])
	) as pv











	select lastname, [1996], [1997], [1998] from
	(
	select lastname, (unitprice*quantity) as PosSumme, year(orderdate) as Jahr from kundeumsatz
	) as KU
	PIVOT
	(
	sum(Possumme) for Jahr in([1996], [1997], [1998])
	) as pv


select * from tab cross apply f(spalte)