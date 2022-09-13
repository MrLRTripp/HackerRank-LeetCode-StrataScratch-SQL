SET search_path to data_sci


SELECT  e.salary, e.department_id,
dense_rank() over (PARTITION by e.department_id order by e.salary DESC) as rank
from employees e
where e.department_id =1
order by e.salary DESC
limit 5


-- Find people with top 3 salaries in each department.
-- There can be more than one person that has a top 3 salary but that is ok since 
-- dense_rank gives them the same rank
with rank_sal AS
	(SELECT e.salary, e.last_name, e.department_id,
	    dense_rank() over (PARTITION by e.department_id order by e.salary DESC) as rank
	from employees e)
select rs.salary, rs.last_name, d.department_name
from company_departments d
join rank_sal rs on d.id = rs.department_id
where rank <=3
order by d.department_name, rs.salary DESC


-- Another solution does the join in the CTE
-- A little cleaner to do it this way since it is still not that complex and keeps the
-- main select super simple
with rank_sal AS
	(SELECT e.salary, e.last_name, e.department_id, d.department_name,
	    dense_rank() over (PARTITION by e.department_id order by e.salary DESC) as rank
	from employees e
	join company_departments d on d.id = e.department_id)
select rs.salary, rs.last_name, rs.department_name
from rank_sal rs 
where rank <=3
order by rs.department_name, rs.salary DESC


-- duplicate salary for rank 2 in dept 1 so we can show that the query works in 
-- this situation.
select * from employees
where department_id = 1
order by salary desc
limit 5

"id"	"last_name"	"email"	"start_date"	"salary"
460	"sanchez"	"lsanchezcr@rediff.com"	"2019-11-18"	146167
22	"alexander"	"kalexanderl@marketwatch.com"	"2021-10-20"	144724
553	"george"	"rgeorgefc@youtube.com"	"2020-04-29"	141505
327	"edwards"	"medwards92@mail.ru"	"2021-09-30"	140194

update  employees
set salary = 144724
where id = 553

select * from employees
where department_id = 1
order by salary desc
limit 5

"id"	"last_name"	"email"	"start_date"	"salary"
460	"sanchez"	"lsanchezcr@rediff.com"	"2019-11-18"	146167
22	"alexander"	"kalexanderl@marketwatch.com"	"2021-10-20"	144724
553	"george"	"rgeorgefc@youtube.com"	"2020-04-29"	144724
327	"edwards"	"medwards92@mail.ru"	"2021-09-30"	140194

