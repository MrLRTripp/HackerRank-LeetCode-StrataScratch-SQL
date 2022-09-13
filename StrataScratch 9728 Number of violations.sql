set search_path to data_sci

create table sf_restaurant_health_violations (
business_id int,
business_name text,
business_address text,
business_city text,
business_state text,
business_postal_code real,
business_latitude real,
business_longitude real,
business_location text,
business_phone_number real,
inspection_id text,
inspection_date date,
inspection_score real,
inspection_type text,
violation_id text,
violation_description text,
risk_category text
)



-- You're given a dataset of health inspections. Count the number of violation in an 
-- inspection in 'Roxanne Cafe' for each year. If an inspection resulted in a violation, 
-- there will be a value in the 'violation_id' column. Output the number of violations by 
-- year in ascending order.


select extract(YEAR from inspection_date) inspection_year, count(violation_id) num_violations
from sf_restaurant_health_violations
where business_name = 'Roxanne Cafe'
group by inspection_year
order by inspection_year


insert into sf_restaurant_health_violations
(business_name,inspection_date, violation_id )
VALUES
('Roxanne Cafe', '2019-01-01'::date, 'bob'),
('Roxanne Cafe', '2019-01-02'::date, Null)

select extract(YEAR from inspection_date) inspection_year, violation_id
from sf_restaurant_health_violations
where business_name = 'Roxanne Cafe'
order by inspection_year