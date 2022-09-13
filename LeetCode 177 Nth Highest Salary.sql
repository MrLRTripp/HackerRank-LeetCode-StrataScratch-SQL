set search_path to data_sci

select * from  employees
order by salary DESC

limit 11

-- $$ is a Postgres block quote
create or REPLACE FUNCTION getNthHighestSalary(N INT) RETURNS INT
AS
$$
      select e.salary from employees e
	  order by e.salary DESC
	  offset N-1 -- The offset is n-1 so it returns the nth value
	  limit 1

$$ language sql

select getNthHighestSalary(10)

"getnthhighestsalary"
149099


select getNthHighestSalary(10000)
-- Returns null as desired


