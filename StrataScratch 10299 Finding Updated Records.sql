set search_path to data_sci

truncate table ms_employee_salary
create table ms_employee_salary (
id int,
first_name text,
last_name text,
salary int,
department_id int
)

select count(distinct id) , count(id)
from ms_employee_salary

-- We have a table with employees and their salaries, however, some of the records are 
-- old and contain outdated salary information. Find the current salary of each employee 
-- assuming that salaries increase each year. Output their id, first name, last name, 
-- department ID, and current salary. Order your list by employee ID in ascending order.
select id,first_name, last_name,department_id,
max(salary)
from ms_employee_salary
group by id,first_name, last_name,department_id
order by id ASC
