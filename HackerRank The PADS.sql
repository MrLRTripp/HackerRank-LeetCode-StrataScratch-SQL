set search_path to data_sci

-- Hackerrank PADS question
-- Since we have employees table, use it instead of new occupations table
-- Query an alphabetically ordered list of all names in OCCUPATIONS, 
-- immediately followed by the first letter of each profession as a parenthetical 
-- (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), 
-- AProfessorName(P), and ASingerName(S).

select distinct job_title FROM
employees

SELECT count (*)
from employees

select distinct concat('(',
			upper(substring(job_title from 1 for 1))
			,')')
from employees

select concat(last_name, 
		'(',
		upper(substring(job_title from 1 for 1))
		,')')
from employees
order by last_name;


-- Query the number of ocurrences of each occupation in OCCUPATIONS. 
-- Sort the occurrences in ascending order, and output them in the following format:
--     There are a total of [occupation_count] [occupation]s.
-- where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS 
-- and [occupation] is the lowercase occupation name. If more than one Occupation 
-- has the same [occupation_count], they should be ordered alphabetically.

select Concat('There are a total of ', count(job_title), ' ',lower(job_title), 's.')
from employees
group by job_title
order by  count(job_title) ASC, job_title asc;
