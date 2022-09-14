-- Find the rate of processed tickets for each type.

select type, 
sum(case when processed = True then 1 else 0 end)::real /
count (processed) as processed_rate
from facebook_complaints
group by type