set search_path to data_sci

create table yelp_business (
business_id text,
name text,
neighborhood text,
address text,
city text,
state text,
postal_code text,
latitude real,
longitude real,
stars real,
review_count int,
is_open int,
categories text

)


-- Find the top business categories based on the total number of reviews. 
-- Output the category along with the total number of reviews. Order by total reviews 
-- in descending order.



with cte_split_categories as (
select review_count, unnest(string_to_array(categories,';')) category
from yelp_business
	)
select category, sum(review_count)
from cte_split_categories
GROUP by category
order by 2 DESC	

