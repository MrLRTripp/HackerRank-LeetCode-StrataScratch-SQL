set search_path to data_sci

create table facebook_employees(
id int,
location text,
age int,
gender text,
is_senior BOOLEAN
	)
	
CREATE TABLE facebook_hack_survey (
employee_id int,
age int,
gender text,
popularity int
)

-- Meta/Facebook has developed a new programing language called Hack.To measure the 
-- popularity of Hack they ran a survey with their employees. The survey included data 
-- on previous programing familiarity as well as the number of years of experience, age, 
-- gender and most importantly satisfaction with Hack. Due to an error location data was 
-- not collected, but your supervisor demands a report showing average popularity of Hack 
-- by office location. Luckily the user IDs of employees completing the surveys were stored.
-- Based on the above, find the average popularity of the Hack per office location.
-- Output the location along with the average popularity.

select fe.location, round(avg(fs.popularity), 2)
from facebook_hack_survey fs
inner join facebook_employees fe on fe.id = fs.employee_id
group by fe.location
order by fe.location
