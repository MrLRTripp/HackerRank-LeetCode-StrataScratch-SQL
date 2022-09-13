
-- StrataScratch
-- Most Profitable Companies
-- ID 10026

-- Find the 3 most profitable companies in the entire world.
-- Output the result along with the corresponding company name.
-- Sort the result based on profits in descending order

With cte as (
select company, profits,
    rank() over (order by profits desc) profit_rank
from forbes_global_2010_2014
group by company, profits)
select company, profits
from cte
where profit_rank <= 3
order by profits desc