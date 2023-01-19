-- DataQuest.io SQL project
-- stores.db
--
-- Count number of distinct customers per month and use it to compute 4-month rolling sum and average
with distCustYM as (
SELECT count(distinct o.customerNumber) numDistCust, strftime('%Y-%m',o.orderDate) ordYM
from orders o
GROUP by ordYM
order by ordYM ASC)

SELECT ordYM,
sum(numDistCust) OVER (
  ORDER BY ordYM ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) rollingSumCust4M,
round(avg(numDistCust) OVER (
  ORDER BY ordYM ROWS BETWEEN 4 PRECEDING AND CURRENT ROW),1) rollingAvgCust4M
from distCustYM
order by ordYM ASC;

