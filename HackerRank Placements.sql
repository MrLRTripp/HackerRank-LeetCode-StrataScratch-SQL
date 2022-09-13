set search_path to data_sci

select substring ('asubstring' from '.{3}$')

select distinct last_name FROM
employees
where lower(right(last_name,1))  in ('a','e','i','o','u')
order by last_name ASC


select 
array_agg(job_title) over (partition by job_title order by job_title asc)
from employees
ORDER by right(job_title,1)


select job_title, count(id) as num_emp
from employees
group by job_title
order by num_emp desc


create table students(
id integer,
name text);

create table friends(
id integer,
friend_id integer);

create table packages(
id integer,
salary real);

INSERT into students
values
(1,'name1'),
(2, 'name2'),
(3, 'name3'),
(4, 'name4');

insert into friends
values
(1,2),
(2,3),
(3,4),
(4,1);

insert into packages
values
(1, 15.0),
(2,10.0),
(3, 11.0),
(4,12.0);


-- Find friend sal
with f_sal as(
	select s.id s_id, f.friend_id f_id, p.salary friend_salary
	from students s
	join friends f on s.id = f.id
	join packages p on f.friend_id = p.id
	order by s.id asc
	)
select s.name, p.salary
from students s
join packages p on s.id = p.id
join f_sal on s.id = f_sal.s_id
where p.salary < f_sal.friend_salary
order by f_sal.friend_salary

-- Can actually do this in one select by joining to packages twice
-- select s.id s_id, f.friend_id f_id, sp.salary student_salary, fp.salary friend_salary
select s.name
from students s
join friends f on s.id = f.id
join packages sp on s.id = sp.id
join packages fp on f.friend_id = fp.id
where sp.salary < fp.salary
order by fp.salary asc
