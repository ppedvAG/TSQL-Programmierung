--UNPIVOT

SELECT * FROM  pivotdemo


SELECT Jahr, Monat, Umsatz
FROM 
   (SELECT Jahr, [1],[2],[3],[4],[5],[6]
   FROM pivotdemo) p
UNPIVOT
   (umsatz  FOR Monat  IN 
      ( [1],[2],[3],[4],[5],[6])
)AS unpvt;
GO