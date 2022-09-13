set search_path to data_sci


-- Find the top 5 businesses with most reviews. Assume that each row has a unique business_id such that the 
-- total reviews for each business is listed on each row. Output the business name along with the total number 
-- of reviews and order your results by the total reviews in descending order.

-- Use rank() since we are tryig to limit the number of businesses to 5 even if there are ties.
-- Use dense_rank() if the question was to find the businesses with the top 5 review counts. 

with cte as (
    select name, review_count,
    rank() over (order by review_count desc) ranking
    from yelp_business
    group by name, review_count
    )
select name, review_count
from cte 
where ranking <= 5
order by review_count desc