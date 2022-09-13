set search_path to data_sci

CREATE TABLE yelp_reviews (
business_name text,
review_id text,
user_id text,
stars text,
review_date date,
review_text text,
funny int,
useful int,
cool int

)

-- Find the review_text that received the highest number of  'cool' votes.
-- Output the business name along with the review text with the highest number of 'cool' votes.

SELECT count(DISTINCT review_text), count( review_text)
from yelp_reviews

SELECT y1.business_name, y1.review_text
from yelp_reviews y1
WHERE y1.cool = (select max(y2.cool) from yelp_reviews y2)
