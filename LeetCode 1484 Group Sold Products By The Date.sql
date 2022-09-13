set search_path to data_sci

drop table if exists activity;

CREATE table activity (
	sell_date date,
	product text)
	
insert into activity
VALUES
('2020-05-30','Headphone'),
('2020-06-01','Pencil'),
('2020-06-02','Mask'),
('2020-05-30','Basketball'),
('2020-06-01','Bible'),
('2020-06-02','Mask'),
('2020-05-30','T-Shirt');


-- Write an SQL query to find for each date the number of different products sold and their names.
-- The sold products names for each date should be sorted lexicographically.
-- Return the result table ordered by sell_date.
select sell_date, count(distinct(product)) num_sold, 
		string_agg(distinct(product),',' order by product ASC ) products
from activity 
group by sell_date
order by sell_date


select to_char(sell_date, 'YYYY-MM')
from activity
