set search_path to data_sci


-- Find the top 5 states with the most 5 star businesses. Output the state name along 
-- with the number of 5-star businesses and order records by the number of 5-star businesses 
-- in descending order. In case there are ties in the number of businesses, return all the 
-- unique states. If two states have the same result, sort them in alphabetical order.

-- Use rank()
-- Use dense_rank() if the question was to find the states with top 5 number of 5-star businesses

with cte_rank as (
	select state, count(business_id) num_5_stars,
	rank() over (order by count(business_id) desc ) state_rank
	from yelp_business
	where stars = 5
	group by state
	order by num_5_stars DESC
	)
select state, num_5_stars
from cte_rank 
where state_rank <= 5
order by num_5_stars desc, state ASC