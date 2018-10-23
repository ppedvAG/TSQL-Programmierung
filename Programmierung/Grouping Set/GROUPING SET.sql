SELECT customerid, year(orderdate), SUM(freight)
FROM orders
GROUP BY GROUPING SETS ((customerid), year(orderdate),(customerid))


SELECT customerid, year(orderdate), SUM(freight)
FROM orders
GROUP BY ROLLUP (customerid), ROLLUP ( year(orderdate),(customerid))