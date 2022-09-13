set search_path to data_sci

create table fb_eu_energy (
	date date,
	consumption int
	);
	
create table fb_asia_energy (
	date date,
	consumption int
	);
	
create table fb_na_energy (
	date date,
	consumption int
	);
	


-- Find the date with the highest total energy consumption from the Meta/Facebook data centers. 
-- Output the date along with the total energy consumption across all data centers.


select date, sum(consumption)
from fb_eu_energy
group by date


-- Some solutions use dense_rank instead of limit.
-- That would handle more than one date with max energy
with all_locations as (
select * from fb_eu_energy
UNION ALL
select * from fb_asia_energy
Union ALL
select * from fb_na_energy
	)
SELECT date, sum(consumption)
	from all_locations
group by date
order by 2 DESC
limit 1
	
