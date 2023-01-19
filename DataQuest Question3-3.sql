-- DataQuest.io SQL project
-- stores.db
--
-- Compute average customer lifetime value by computing average profit per customer
with orderProfit as( SELECT od.orderNumber ,  sum(od.quantityOrdered * (od.priceEach - p.buyPrice)) as profit
from orderdetails od
INNER join products p on p.productCode = od.productCode
GROUP by od.orderNumber)
,

profitByCust as (
SELECT  o.customerNumber, sum(op.profit) as profitByCustomer
from orders o
INNER join orderProfit op on op.orderNumber = o.orderNumber
INNER JOIN customers c on c.customerNumber = o.customerNumber
GROUP by o.customerNumber
)

select round(avg(p.profitByCustomer),2) avgProfitPerCust
from profitByCust p;