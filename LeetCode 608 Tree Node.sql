set search_path to data_sci


-- What makes this a little tricky is that any comparison (=, <>) to NULL is always False
-- ALL will return NULL if there are no matches and there is a NULL in the result set.
-- In this case, there is a NULL in parent_department_id.
-- Therefore, you need a WHERE clause to exclude parent_department_id is NULL.
-- The situation is taken care of in the first case statement.
-- If not a Root or Leaf, the ELSE will label as Inner
select id, 
-- root_leaf_inner 
case when parent_department_id is NULL then 'Root'
	 when id <> ALL (select parent_department_id 
					 from org_structure 
					 where parent_department_id is not NULL) then 'Leaf'
	 else 'Inner'
END
from org_structure
order by id ASC


-- This is better since you don't have to deal with the funny way ALL handles NULL
SELECT
    id,
    CASE
        WHEN parent_department_id IS NULL THEN 'Root'
        WHEN id IN (SELECT parent_department_id FROM org_structure) THEN 'Inner'
        ELSE 'Leaf'
    END as Type
FROM
    org_structure
order by id ASC




select * from org_structure
where parent_department_id <> NULL

