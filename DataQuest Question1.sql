-- DataQuest.io SQL project
-- stores.db
--
-- which products should we order more of or less of? 
-- This question refers to inventory reports, including low stock and product performance.
SELECT p.productCode,p.productName,  round(sum(od.quantityOrdered)*1.0/p.quantityInStock,2) as lowStock, sum(od.quantityOrdered * od.priceEach) as productPerformance
from orderdetails od
INNER JOIN products p on od.productCode = p.productCode
GROUP by p.productName
ORDER by lowStock ASC, productPerformance DESC;

