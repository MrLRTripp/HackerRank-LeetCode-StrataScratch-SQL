set search_path to data_sci

-- Classify each business as either a restaurant, cafe, school, or other. 
-- A restaurant should have the word 'restaurant' in the business name. 
-- For cafes, either 'cafe', 'café', or 'coffee' can be in the business name. 
-- 'School' should be in the business name for schools. All other businesses should be 
-- classified as 'other'. Output the business name and the calculated classification.

-- needs a DISTINCT since there can be multiple rows for business
select distinct business_name,
case when lower(business_name) like '%restaurant%' then 'restaurant'
     when lower(business_name) LIKE any(ARRAY['%cafe%', '%café%','%coffee%']) then 'cafe'
	 when lower(business_name) LIKE '%school%' then 'school'
	 else 'other'
end classification
from sf_restaurant_health_violations


