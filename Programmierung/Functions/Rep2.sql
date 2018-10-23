--Rep2


--Indizes

--Seek!  ...
--Scan A bis Z

--Table Scan vs CL IX Scan?
--da CL IX = Tabelle!

NON CL IX SCAN ... CL|Table Scan

IX Seek vs IX Scan.. Seek!

NCL IX Seek -- > CL IX 
NCL IX Seek -->  Table (heap)




select * from customers c 
	inner join orders o on o.CustomerID=c.CustomerID



select * from customers c 
	inner loop join orders o on o.CustomerID=c.CustomerID


select * from customers c 
	inner hash join orders o on o.CustomerID=c.CustomerID