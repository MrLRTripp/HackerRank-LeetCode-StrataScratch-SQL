-- Assume you are given the table below on Uber transactions made by users. Write a query to obtain the 
-- third transaction of every user. Output the user id, spend and transaction date.

with cte as (
  SELECT user_id , spend,transaction_date,
  row_number() over (partition by user_id ORDER BY transaction_date asc) r_num
  
  FROM transactions
  GROUP BY user_id , spend, transaction_date
  )
SELECT user_id, spend, transaction_date
from cte
where r_num = 3