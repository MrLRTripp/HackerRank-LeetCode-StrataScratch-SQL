
-- StrataScratch
-- Find all wineries which produce wines by possessing aromas of plum, cherry, rose, or hazelnut
-- ID 10026

--Find all wineries which produce wines by possessing aromas of plum, cherry, rose, or hazelnut. 
-- To make it more simple, look only for singular form of the mentioned aromas.
-- Output unique winery values only.

-- Punctuation and special characters before and after are permitted, by no letters
select distinct(winery)
from winemag_p1 
where regexp_match(lower(description) , '([^a-z]plum[^a-z])|([^a-z]cherry[^a-z])|([^a-z]rose[^a-z])|([^a-z]hazelnut[^a-z])') is not NULL
order by winery asc


-- Better solution using ~ operator
SELECT DISTINCT winery
FROM winemag_p1
WHERE lower(description) ~ '[^a-z](plum|cherry|rose|hazelnut)[^a-z]'

SELECT DISTINCT winery
FROM winemag_p1
WHERE lower(description) ~ '\y(plum|cherry|rose|hazelnut)\y'