-- Find the number of times the words 'bull' and 'bear' occur in the contents. We're counting the number of times 
-- the words occur so words like 'bullish' should not be included in our count.
-- Output the word 'bull' and 'bear' along with the corresponding number of occurrences.

-- Some files contain both bull and bear
-- Put the words bull and bear in one column and group by it
-- Some files don't have either so use having by to filter the group result

with cte as (
    select filename,
    case when lower(contents) ~ '\y(bull)\y' then 'bull' end as words
    from google_file_store
    union 
    select filename,
    case when lower(contents) ~ '\y(bear)\y' then 'bear' end as words
    from google_file_store
)
select words, count(words)
from cte
group by words
having count(words) > 0


-- Using Postgres specific text search functions
SELECT 
    word,nentry                                       
FROM  
    ts_stat('SELECT to_tsvector(contents) FROM google_file_store') 
WHERE
    word ILIKE 'bull' or word ILIKE 'bear'