-- Assume you are given the table below containing the information on the searches attempted and the percentage 
-- of invalid searches by country. Write a query to obtain the percentage of invalid search result.

-- Output the country (in ascending order), total number of searches and percentage of invalid search rounded to 
-- 2 decimal places.

-- Note that to find the percentages, multiply by 100.0 and not 100 to avoid integer division.

-- Definition and assumptions:
-- num_search is the number of searches attempted and invalid_result_pct is the percentage of invalid searches.
-- In cases where countries has search attempts but does not have an invalid result percentage, it should 
-- be excluded, and vice versa.


-- There are NULL values in num_search and invalid_result_pct so ignore those rows
with cte_num_invalid as (
  SELECT country, search_cat, num_search, 
  (num_search * invalid_result_pct / 100.0) num_invalid_search
  FROM search_category
  where num_search is not NULL
  and invalid_result_pct is not NULL
)

select country, SUM(num_search) total_searches,  
ROUND((sum(num_invalid_search)/SUM(num_search))*100.0,2) pct_invalid_searches
from cte_num_invalid
group by country
order by country