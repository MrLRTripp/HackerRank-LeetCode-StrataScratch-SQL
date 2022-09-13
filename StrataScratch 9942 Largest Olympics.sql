-- Find the Olympics with the highest number of athletes. The Olympics game is a combination of the year and 
-- the season, and is found in the 'games' column. Output the Olympics along with the corresponding number of athletes.

-- Instead of rank, could have used max since only wanted top 1

with cte_num as (
    select games, count(distinct id) num_atheletes,
    rank() over (order by count(distinct id) desc ) ranking
    from olympics_athletes_events 
    group by 1
)
select games, num_atheletes
from cte_num
where ranking = 1