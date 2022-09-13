set search_path to data_sci


create table airbnb_host_searches(
id int,
price real,
property_type text,
room_type text,
amenities text,
accommodates int,
bathrooms int,
bed_type text,
cancellation_policy text,
cleaning_fee boolean,
city text,
host_identity_verified text,
host_response_rate text,
host_since date,
neighbourhood text,
number_of_reviews int,
review_scores_rating real,
zipcode int,
bedrooms int,
beds int
	)
	
	
-- You’re given a table of rental property searches by users. The table consists of search 
-- results and outputs host information for searchers. 
-- Find the minimum, average, maximum rental prices for each host’s popularity rating. 
-- The host’s popularity rating is defined as below:
-- 0 reviews: New
-- 1 to 5 reviews: Rising
-- 6 to 15 reviews: Trending Up
-- 16 to 40 reviews: Popular
-- more than 40 reviews: Hot	

with cte_pop_rating as (
select id,price,
case when number_of_reviews = 0 then 'New'
	when number_of_reviews between 1 and 5 then 'Rising'
	when number_of_reviews between 6 and 15 then 'Trending Up'
	when number_of_reviews between 16 and 40 then 'Popular'
	WHEN number_of_reviews > 40 then 'Hot'
END as popularity_rating
from airbnb_host_searches
)
select 'New' popularity_category,min(price), round(avg(price)::numeric,2) avg_price , max(price)
from cte_pop_rating
where popularity_rating = 'New'
UNION
select 'Rising' popularity_category,min(price), round(avg(price)::numeric,2) avg_price , max(price)
from cte_pop_rating
where popularity_rating = 'Rising'
UNION
select 'Trending Up' popularity_category,min(price), round(avg(price)::numeric,2) avg_price , max(price)
from cte_pop_rating
where popularity_rating = 'Trending Up'
UNION
select 'Popular' popularity_category,min(price), round(avg(price)::numeric,2) avg_price , max(price)
from cte_pop_rating
where popularity_rating = 'Popular'
UNION
select 'Hot' popularity_category,min(price), round(avg(price)::numeric,2) avg_price , max(price)
from cte_pop_rating
where popularity_rating = 'Hot'

-----------------------
with cte_pop_rating as (
select id,price,
case when number_of_reviews = 0 then 'New'
	when number_of_reviews between 1 and 5 then 'Rising'
	when number_of_reviews between 6 and 15 then 'Trending Up'
	when number_of_reviews between 16 and 40 then 'Popular'
	WHEN number_of_reviews > 40 then 'Hot'
END as popularity_rating
from airbnb_host_searches
)

select distinct popularity_rating,
min(price) over (partition by popularity_rating) as min_price,
round(avg(price) over (partition by popularity_rating)::numeric,2) as avg_price,
max(price) over (partition by popularity_rating) as max_price
from cte_pop_rating

