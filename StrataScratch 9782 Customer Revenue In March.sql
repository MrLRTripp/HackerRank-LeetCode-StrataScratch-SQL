set search_path to data_sci

-- Calculate the total revenue from each customer in March 2019. Include only customers 
-- who were active in March 2019.
-- Output the revenue along with the customer id and sort the results based on the 
-- revenue in descending order.

select * from azorders
order by order_date asc

select cust_id, sum(total_order_cost) total_orders
from azorders
where to_char(order_date , 'yyyy-mm') = '2019-03'
group by cust_id
order by total_orders DESC