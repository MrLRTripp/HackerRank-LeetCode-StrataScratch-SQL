-- Say you have access to all the transactions for a given merchant account. Write a query to print the 
-- cumulative balance of the merchant account at the end of each day, with the total balance reset back to zero 
-- at the end of the month. Output the transaction date and cumulative balance.



with cte_daily as (
  SELECT transaction_date::date x_date,
  sum(case when type = 'deposit' then amount
    else amount*-1.0 end) daily_balance
  FROM transactions
  group by 1
  order by 1
)
  --SELECT cd1.x_date,cd1.daily_balance,cd2.x_date,cd2.daily_balance
  select cd1.x_date,
  round(sum(cd2.daily_balance),2)
  from cte_daily cd1
  cross join  cte_daily cd2
  where extract(day from cd1.x_date) >= extract(day from cd2.x_date)
  and extract(month from cd1.x_date) = extract(month from cd2.x_date)

GROUP BY cd1.x_date
ORDER BY cd1.x_date


--------------------
A better solution is to use the sum(daily_balance) over a monthly partition orderd by date
The sum will automatically compute cumulative sum.