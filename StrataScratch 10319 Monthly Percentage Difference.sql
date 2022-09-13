set search_path to data_sci

create table sf_transactions (
id int,
created_at date,
value int,
purchase_id int)

-- Given a table of purchases by date, calculate the month-over-month percentage change 
-- in revenue. The output should include the year-month date (YYYY-MM) and percentage change, 
-- rounded to the 2nd decimal point, and sorted from the beginning of the year to the 
-- end of the year.
-- The percentage change column will be populated from the 2nd month forward and can be 
-- calculated as ((this month's revenue - last month's revenue) / last month's revenue)*100.

with cte_month as (
	select to_char(created_at, 'yyyy-mm') y_m , sum(value) month_total
	from sf_transactions
	group by to_char(created_at, 'yyyy-mm')
	ORDER by to_char(created_at, 'yyyy-mm')
	),
lag1 as (
	select cte_month.y_m, cte_month.month_total,
		lag(cte_month.month_total, 1) over (order by cte_month.y_m asc) lag1
	from cte_month
	group by cte_month.y_m, cte_month.month_total
	order by cte_month.y_m, cte_month.month_total
	)
	
select y_m year_month,
	round((((month_total - lag1)::real / lag1)*100)::numeric,2) pct_change
from lag1
order by y_m ASC
	