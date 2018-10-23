--
/*
Welche Arten von Indizes gibts eigtl..?

Clustered Index
NON Clust IX
-------------------------------
gefilterte IX
IX mit eingeschlossenen Spalten
partitionierten IX
zusammengsetzter IX
abdeckender IX
eindeutige IX
indizierte Sicht
----------------ENT
Columnstore IX

*/

SELECT     Customers.CustomerID, Customers.CompanyName, Customers.City, Customers.Country, Employees.LastName, Employees.FirstName, [Order Details].UnitPrice, [Order Details].Quantity, [Order Details].OrderID, Orders.OrderDate, Orders.ShipCity, Orders.Freight, 
                  Orders.ShipCountry
into UMSATZ
FROM        Customers INNER JOIN
                  Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                  Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                  [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                  Products ON [Order Details].ProductID = Products.ProductID

--vervielfachen
--2 Mio wären ok
insert into umsatz
select * from umsatz

--ID dazu
alter table umsatz add UID int identity

select top 100 * from umsatz


--NON CLUSTERED

--ab jetzt nur noch Prognosen?
select * from umsatz -- Table SCAN

select * from umsatz where freight = 11.61 -- Table Scan


select count(*) from umsatz where freight = 11.61 -- Table Scan --2048 von 2 mIo

--NCL wäre ok..(10 bis 20% Treffer von der Gesamtmenge)
USE [Northwind]

GO

CREATE NONCLUSTERED INDEX [NIX_Freight] ON [dbo].[UMSATZ]
(
	[Freight] ASC
)

--der IX kann bisher nur beantworten, wo der DS liegt
select *  from umsatz where freight = 11.61 --Plan?  -- telefonbuch

USE [Northwind]
GO

/****** Object:  Index [NIX_Freight_Country_City]    Script Date: 14.10.2016 16:07:06 ******/
CREATE NONCLUSTERED INDEX [NIX_Freight_Country_City] ON [dbo].[UMSATZ]
(
	[Freight] ASC,
	[City] ASC,
	[Country] ASC
)

select freight, city, country from umsatz where freight = 11.61
--Lookup auf Heap ist weg , kostet vorher 50%
--Ziel : versuche Lookups zu vermeiden

--besser: wenn wir denb Baum nicht belasten würden, sondern der IX 
--uns alles beantworten kann über die Blattebene
--IX mit eingeschl. Spalten

USE [Northwind]

GO

SET ANSI_PADDING ON


GO

CREATE NONCLUSTERED INDEX [NIX_FR_INKL_SC_SY] ON [dbo].[UMSATZ]
(
	[Freight] ASC
)
INCLUDE ( 	[City],
	[Country]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)

GO

--nun haben wir 2 IX, die dsa erledigen könnten
select freight, city, country from umsatz where freight = 11.61

--warum nicht den INKL COLUMN IX? 
--beide wären gleich schnell wg 3 Ebenen
--Objectid entscheidet


--zusammengesetzter IX NIX_Freight_Country_City
--kann max 16 Spalten haben und belastet damit auch den Baum massiv


--IX mit eingeschl.. NIX_FR_INKL_SC_SY
--kann 1024 eingeschl. Spalten haben.. effektiv könnte das die ganze Tabelle sein
--ABER KOPIE der Daten

--aber die Perf ist saucool
set statistics io on

select freight, city, country from umsatz where freight = 11.61
--18 seiten

select freight, city, country from umsatz
with (index=[NIX_FR_INKL_SC_SY])
 where freight = 11.61
 -- 101308 bei scan,, bei IX mit inkl. Columns 19 Seiten

select freight, city, country from umsatz
 where freight = 11.61 and city = 'London'

 USE [Northwind]

GO

SET ANSI_PADDING ON


GO

CREATE NONCLUSTERED INDEX [NIX_FR_SY_ink_SC__Ttest2] ON [dbo].[UMSATZ]
(
	[Freight] ASC,
	[City] ASC
)
INCLUDE ( 	[Country]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)

GO

CREATE NONCLUSTERED INDEX [NIX_FR_SY_ink_SC__Ttest3] ON [dbo].[UMSATZ]
(
	
	[City] ASC,[Freight] ASC
)
INCLUDE ( 	[Country]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)

GO


--beide IXs haben nichts weiter gebracht, da Freight selektiv genug
--aber nun meher DAten (30000 Seiten)
--bei jedem INS, UP, DEL müssen alle Indizes korrigiert werden
--nun 5 Insert, obwohl die 2 neuen nie verwendet wurden/werden

--wie würde der CL IX im realen Leben aussehen
--in München Clustered IX
--alle Leute müssen umziehen

--wie oft kann es den CL IX geben--nur 1 mal
--Tab exisitiert nur einmal

--wenn der CL IX gut auf Bereichsabfragen ist, dann
--sollte man sich das zu Beginn gut überlegen

--bei UMSATZ CL IX auf orderdate
--achtung bei erstellung des CL IX werden alle Zeiger der NCL korrigiert!

select * from umsatz where orderdate < '1.1.1998' --reiner Seek
--bei CL IX Seek kann es keinen lookup mehr geben

select * from umsatz where freight = 11.61 --kein NCL kann den * beantworten

select country, city from umsatz where freight = 11.61 --reiner IX Seek

--wenn ein reiner Seek vorliegt, dann hast du einen abdeckenden IX

--wer über die GUI einen PK setzt: Vorsicht SQL Server versucht, wenn möglich einen CL IX zu machen
--GUID , Identity kann der NCL sehr gut
--aber der CL hier drauf ist Verschwendung.. besser für Bereiche definieren


--IX eindeutig mit CL ist schon ein bisschen Verschwendung ;-)

--partitionierung ist physikalische Verteilung des IX auf der HDD (mehrere HDD)
--Salamitaktik

--wichtiger: gefilterte IX 
--hat nicht mehr alle Daten enthalten
--das sind genau unsere Telefonbücher... kein Telbuch von GER
--sondern nur pro Stadt



select city, country, unitprice from umsatz where freight = 11.61 and city = 'London'

--gefilterter
select city, country, unitprice  from umsatz where freight = 11.61 and city = 'Berlin'
--6000 statt 3

--Indizierte Sicht





-- Anlegen von Indizes
create [unique] non clustered Index indexname on Tabelle (spalten) include (Spalten) where Filter = ()
create clustered index Indexanem on Tabelle (Spalten) 

--Indizierte Sicht!:
--muss with schemabinding, unique, clustered, kein Outer Join, bei Aggregaten Count_big(*) aufweisen

-- wird nur von Ent/Dev beachtet. Alle anderen Editione müssen (NOEXPAND) auifweisen

set statistics io on
set statistics time on

select country, sum(freight) as Summe
  from Umsatz
  group by country
go

--UMSATZ-Tabelle. Scananzahl 5, logische Lesevorgänge 17471, physische Lesevorgänge 0, Read-Ahead-Lesevorgänge 14, logische LOB-Lesevorgänge 0, physische LOB-Lesevorgänge 0, Read-Ahead-LOB-Lesevorgänge 0.

 --SQL Server-Ausführungszeiten: 



alter view vUmsatz with schemabinding as
select country, sum(freight) as Summe,count_big(*) as anzahl
  from dbo.Umsatz
  group by country
go 

select * from VUmsatz --21 Zeilen--dh IX besitzt nur 21 Datensätze
--dh die Abfrage über die Sicht ist extrem schnell..2 Seiten statt 17000

--werden Daten geändert dann muss aich der IX der Sicht aktualisiert werden



create unique clustered index Ix_VUmsatz_Country on VUmsatz (country)
GO

--Daten liegen nun physikalisch vor

--x Seiten bei 10 MIO DS
--x             100 TRilliarden DS

--ca 3 seiten bei ca 200 Ländern egal



select * from V1


select * from V1 with (Index=0)
go

select Nr,count(*)
  from T1
  group by Nr

  --dann wird bei der ENT automatisch die sicht verwendet!!!



  200MB Heap

  NCL A 60MB
  NCL B 80

  CL 230 MB
  ---360MB..
  --IX ON OFFLINE, mit und ohne Tempdb
  --günstig: off ohne tempdb..    860
  --aufwendiger: on mit tempdb    1043

  --500MB 


A B C
A
B
C
AB
AC
BA
BC
CA
CB
ABC
ACB
BAC
BCA
CAB
CBA
CBA
CBA
CBA
---1023

---NON CL IX.. wenige Zeilen
--CL IX .. wurscht






