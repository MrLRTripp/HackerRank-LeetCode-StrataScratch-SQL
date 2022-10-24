/*
Create and populate three tables based on employee salary.
Oracle has a simple way to do this using the INSERT ALL statement. Since PostgreSQL doesn't
have that, then we'll write an anonymous function DO..END to perform the same thing.
*/

set search_path to data_sci

select count(*)
from employees


select min(salary), max(salary)
from employees

"min"	"max"
40138	149929

/*
Create the three tables.
Yes, this can be done in the function as well, but I want to keep the function
relatively straight forward for illustration purposes.
*/
create table emp_low_sal
(id integer,
last_name text,
salary integer);


create table emp_med_sal
(id integer,
last_name text,
salary integer);

create table emp_high_sal
(id integer,
last_name text,
salary integer);


-----------------------------------------------
/*
Her is what the INSERT ALL statement looks like in Oracle.
insert ALL
	when salary < 75000
		into emp_low_sal
			VALUES (id, last_name, salary, category)
	when salary >= 75000 and salary < 100000
		into emp_med_sal
			VALUES (id, last_name, salary, category)
	when salary >= 100000
		into emp_high_sal
			VALUES (id, last_name, salary, category)

SELECT id,last_name, salary,
	CASE
		when salary < 75000 then 'Low'
		when salary >= 75000 and salary < 100000 then 'Medium'
		when salary >= 100000 then'High'
	END category
	
	from employees
*/	

			
-----------------------------
/*
We will store the parameters for the INSERT INTO statement in array variables.
Then we'll loop through them to populate the INSERT INTO statement.
Note: By default PostgreSQL uses a one-based numbering convention for arrays.
In order to populat the table name, we have to use a format() function with the %I format
type. The EXECUTE statement will then execute the populated INSERT INTO statement.

*/
DO $$

DECLARE
sal_tables text[];
sal_ranges integer[][];

BEGIN
PERFORM set_config('search_path', 'data_sci',true);
sal_ranges := '{{0,70000},{70000,100000},{100000,10000000}}';
sal_tables := '{"emp_low_sal","emp_med_sal","emp_high_sal"}';

for i in 1..3 LOOP
	EXECUTE format(
	'insert into %1$I
			(id, last_name, salary)

			SELECT id,last_name, salary
				from employees
				where salary > %2$s and salary <= %3$s',
		sal_tables[i],sal_ranges[i][1],sal_ranges[i][2]
	);
END LOOP;

END;
$$

--------------------------
-- Validate that the tables were populated
select * from emp_low_sal
limit 10;

select * from emp_med_sal
limit 10;

select * from emp_high_sal
limit 10


   
   