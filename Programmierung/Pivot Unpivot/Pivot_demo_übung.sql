use Northwind;

SELECT MONTH(orderdate), YEAR(orderdate) , freight FROM orders


SELECT *  FROM --INTO pivotdemo
    (SELECT	
		  YEAR(orderdate) AS Jahr, 
	      MONTH(orderdate) AS Monat, 
	   Freight 
    FROM orders) as pvtab
PIVOT
(SUM (freight) FOR Monat IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])) AS pvt

