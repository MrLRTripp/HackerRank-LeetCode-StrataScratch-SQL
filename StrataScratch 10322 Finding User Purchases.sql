set search_path to data_sci

CREATE table amazon_transactions(
id int,
user_id int,
item  text, 
created_at  timestamp,
revenue int								
)

select * from amazon_transactions
where user_id=110
order by created_at
limit 10

select count(user_id)
from amazon_transactions

-- Write a query that'll identify returning active users. A returning active user 
-- is a user that has made a second purchase within 7 days of any other of their purchases. 
-- Output a list of user_ids of these returning active users.

-- This was an interesting one. Have to add the id in the select and group by where
-- the user makes two or more purchases on first day and there is a big gap to next purchase
with cte_lag as(
	select user_id, id, created_at,
	lag(created_at,1) over (partition by user_id order by created_at asc) lag1
	from amazon_transactions
	group by user_id, id, created_at
	order by user_id
	)
SELECT distinct user_id
from cte_lag
where (created_at - lag1)::interval <= '7 days'::interval



-- This is a cleaner solution provided by strata
SELECT DISTINCT(a1.user_id)
FROM amazon_transactions a1
JOIN amazon_transactions a2 ON a1.user_id=a2.user_id
where a1.id <> a2.id
      AND a2.created_at::date-a1.created_at::date BETWEEN 0 AND 7
ORDER BY a1.user_id
order by user_id



