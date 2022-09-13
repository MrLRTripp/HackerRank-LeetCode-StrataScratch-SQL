set search_path to data_sci

create index idx_id on company_departments(id)

-- Three different ways
-- All three have about the same performance

-- Find max salary and name in each department

-- Using a CTE, find max salary in each dept using the group by
-- Then get the employee name by joining with employees table
with max_dept_sal as
	(SELECT max(e.salary) max_sal, d.id, d.department_name
	from employees e
	inner join company_departments d on e.department_id = d.id
	group by d.id
	)
SELECT e.last_name, e.salary, maxs.department_name, maxs.id
from employees e
inner join max_dept_sal maxs on e.department_id = maxs.id
where e.salary = maxs.max_sal

"greene"	149835	"other"	22
-- Just a cheeck for one val
SELECT e.last_name, e.salary, d.department_name, d.id
from employees e
inner join company_departments d on e.department_id = d.id
where d.id = 22
order by e.salary desc

-- Same thing but using a subquery to find max salary in each dept using the group by
-- Then get the employee name by joining with employees table
SELECT e.last_name, e.salary, maxs.department_name, maxs.id
from employees e
inner join  
(SELECT max(e.salary) max_sal, d.id, d.department_name
	from employees e
	inner join company_departments d on e.department_id = d.id
	group by d.id
	) as maxs
	on e.department_id = maxs.id
where e.salary = maxs.max_sal


-- This version is based on a solution from LeetCode
-- https://leetcode.com/problems/department-highest-salary/discuss/2436319/MYSQL-solution-faster-than-99-of-submissions
-- Use a subquery that ranks salary in each department. Use a Where to select top rank.
Select  e.last_name, e.salary, d.department_name
from company_departments d
inner join 
	(SELECT e2.department_id, e2.last_name, e2.salary,
	dense_rank() over(Partition by e2.department_id order by e2.salary desc) as sal_rank
	from employees e2) as e
	on e.department_id = d.id
where sal_rank=1





