-- Given a table of candidates and their skills, you're tasked with finding the candidates best suited for an 
-- open Data Science job. You want to find candidates who are proficient in Python, Tableau, and PostgreSQL.

-- Write a SQL query to list the candidates who possess all of the required skills for the job. 
-- Sort the the output by candidate ID in ascending order.

-- Have to cast array_agg(skill) as text[] so that contains operator <@ works

with cte as (
  SELECT candidate_id,
  array_agg(skill)::text[] candidate_skills
  FROM candidates
  GROUP BY candidate_id
)
select candidate_id
from cte 
where array ['Python', 'Tableau', 'PostgreSQL'] <@ candidate_skills
GROUP BY candidate_id
ORDER BY candidate_id ASC;

-- An alternative solution that does not use PostgreSQL array is to count the skills the user
-- has that belong to required skills. Final candidates must have count = 3