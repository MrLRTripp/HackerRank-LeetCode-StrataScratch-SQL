set search_path to data_sci

CREATE TABLE salesforce_employees (
id int,
first_name text,
last_name text,
age int,
sex text,
employee_title text,
department text,
salary int,
target int,
bonus int,
email text,
city text,
address text,
manager_id int

)

-- Find the highest target achieved by the employee or employees who works under the 
-- manager id 13. Output the first name of the employee and target achieved. 
-- The solution should show the highest target achieved under manager_id=13 and which employee(s) 
-- achieved it.

select first_name, target
from salesforce_employees
where manager_id = 13
and target = 
(select max(se2.target) 
 from salesforce_employees se2
 where se2.manager_id = 13)




