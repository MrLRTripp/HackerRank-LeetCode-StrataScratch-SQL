set search_path to data_sci


--- Window rolling average vs final average.
--- Final average lets you compare an employee's salary to department average
--- A rolling average recomputes on each row when that salary is used to compute average
--- This works for the other window aggregation functions as well.
--- Notice how the rolling average orders by salary.



select last_name, salary, department_id,
round(avg(salary) over (partition by department_id order by salary),2) rolling_avg,
round(avg(salary) over (partition by department_id order by department_id),2) dept_avg
from employees
limit 5;

"last_name"	"salary"	"department_id"	"rolling_avg"	"dept_avg"
"meyer"		42602			1			42602.00	99727.98
"burns"		44377			1			43489.50	99727.98
"duncan"	45774			1			44251.00	99727.98
"marshall"	47281			1			45008.50	99727.98
"peterson"	53964			1			46799.60	99727.98


-- The above query acts like there is an implied frame clause.
-- If we add in the frame clause, we get the same result.
select last_name, salary, department_id,
round(avg(salary) over (partition by department_id order by salary
					   ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT row),2) rolling_avg,
round(avg(salary) over (partition by department_id order by department_id),2) dept_avg
from employees
limit 5;

"last_name"	"salary"	"department_id"	"rolling_avg"	"dept_avg"
"meyer"		42602			1			42602.00	99727.98
"burns"		44377			1			43489.50	99727.98
"duncan"	45774			1			44251.00	99727.98
"marshall"	47281			1			45008.50	99727.98
"peterson"	53964			1			46799.60	99727.98

-- This query just uses two rows to compute the rolling average
select last_name, salary, department_id,
round(avg(salary) over (partition by department_id order by salary
					   ROWS BETWEEN 1 PRECEDING AND CURRENT row),2) rolling_avg,
round(avg(salary) over (partition by department_id order by department_id),2) dept_avg
from employees
limit 5;

"last_name"	"salary"	"department_id"	"rolling_avg"	"dept_avg"
"meyer"		42602			1			42602.00	99727.98
"burns"		44377			1			43489.50	99727.98
"duncan"	45774			1			45075.50	99727.98
"marshall"	47281			1			46527.50	99727.98
"peterson"	53964			1			50622.50	99727.98
