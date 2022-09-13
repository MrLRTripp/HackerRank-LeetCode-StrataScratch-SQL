set search_path to data_sci

with cte_first_date as (
	select user_id, min(created_at) first_date
	from marketing_campaign
	group by user_id
	)
select count (distinct(cfd.user_id))
	from cte_first_date cfd
	inner join marketing_campaign mc on cfd.user_id = mc.user_id
	where mc.created_at > cfd.first_date
	and mc.product_id not in
		(select mc2.product_id
		from marketing_campaign mc2
		inner join cte_first_date cfd2 on cfd2.user_id = mc2.user_id
		where mc2.created_at = cfd2.first_date
		and cfd2.user_id = cfd.user_id)



-----------------------
-- Interesting by one of the users.
-- Rank all transactions by user_id. This can be used to filter transactions greater than
-- the first one.
-- Next, rank all the products purchased by user based on date purchased. The first time a 
-- product is purchased, it gets a rank of 1. If same product is purchased later, it gets a 
-- rank of 2. We are only interested in products purchased for the first time, i.e. rank=1
select 
count(distinct user_id)
from
(select 
dense_rank() over (partition by user_id order by created_at) as rnk1, 
dense_rank() over (partition by user_id , product_id order by created_at) as rnk2,
 user_id, 
 product_id, 
 created_at
from marketing_campaign) foo
where rnk1>1 and rnk2=1