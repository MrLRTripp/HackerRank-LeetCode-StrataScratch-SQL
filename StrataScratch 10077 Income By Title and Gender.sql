-- Find the average total compensation based on employee titles and gender. Total compensation is calculated by 
-- adding both the salary and bonus of each employee. However, not every employee receives a bonus so disregard 
-- employees without bonuses in your calculation. Employee can receive more than one bonus.
-- Output the employee title, gender (i.e., sex), along with the average total compensation.

-- Note: There is a duplicate record in sf_employee for Manager 
-- There is no date column in sf_employee so no need to search for latest

with cte as (select b.worker_ref_id id ,
    sum(b.bonus)  bonus_comp
    from sf_bonus b
    group by b.worker_ref_id 
)

select e.employee_title, e.sex,
avg(e.salary + cte.bonus_comp) avg_total_comp
from cte
inner join sf_employee e on cte.id=e.id
group by 1,2
order by 3 desc