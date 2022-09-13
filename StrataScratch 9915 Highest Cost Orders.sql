set search_path to data_sci

CREATE table customers (
id int,
first_name text,
last_name text,
city text,
address text,
phone_number text
);

create TABLE azorders (
id int,
cust_id int,
order_date date,
order_details text,
total_order_cost int
);



-- Find the customer with the highest daily total order cost between 2019-02-01 to 2019-05-01. 
-- If customer had more than one order on a certain day, sum the order costs on daily basis. 
-- Output customer's first name, total cost of their items, and the date.
-- For simplicity, you can assume that every first name in the dataset is unique.

with daily_total as (
	select cust_id, order_date, sum(total_order_cost) total
	from azorders
	where order_date BETWEEN '2019-02-01'::date and  '2019-05-01'::date
	group by cust_id, order_date
),
ranked as (
	select cust_id, order_date, total,
	rank() over (partition by order_date order by total DESC) order_rank
	from daily_total
	group by cust_id, order_date, total
	),
max_daily as(
	select cust_id, order_date, total,
		rank() over (order by total DESC) total_rank
	from ranked 
	where order_rank = 1
	)

select 	c.first_name, r.total, r.order_date
from customers c
inner join max_daily r on c.id = r.cust_id
where r.total_rank = 1




-------------------------
-- No need for the middle CTE since we don't care about daily maximums only
-- the overall maximim
with daily_total as (
	select cust_id, order_date, sum(total_order_cost) total
	from azorders
	where order_date BETWEEN '2019-02-01'::date and  '2019-05-01'::date
	group by cust_id, order_date
),
max_daily as(
	select cust_id, order_date, total,
		rank() over (order by total DESC) total_rank
	from daily_total 
	)

select 	c.first_name, r.total, r.order_date
from customers c
inner join max_daily r on c.id = r.cust_id
where r.total_rank = 1