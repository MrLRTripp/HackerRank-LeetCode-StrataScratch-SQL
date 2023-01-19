-- DataQuest.io SQL project
-- stores.db
--
-- Find the number of new customers arriving each month.
WITH newCustYM as (
SELECT o.customerNumber, min(strftime('%Y-%m',o.orderDate)) firstordYM
from orders o
GROUP by o.customerNumber
order by firstordYM ASC)


SELECT count(customerNumber),firstordYM
from newCustYM 
GROUP by firstordYM
order by firstordYM ASC;