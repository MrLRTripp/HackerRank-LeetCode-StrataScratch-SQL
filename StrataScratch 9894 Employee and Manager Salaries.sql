set search_path to data_sci

select first_name, salary
from salesforce_employees
where first_name = 'Richerd'


-- Find employees who are earning more than their managers. 
-- Output the employee's first name along with the corresponding salary.

select se.first_name, se.salary
from salesforce_employees se
where se.salary >
	(select mgr.salary 
	 	from salesforce_employees mgr
		where se.manager_id = mgr.id)