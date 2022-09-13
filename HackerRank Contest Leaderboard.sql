set search_path to data_sci

-- add Challenge_id and score columns to submissions

alter TABLE submissions
add column challenge_id INTEGER,
add column score INTEGER


select * from submissions limit 20

select count(*) from submissions
-- 400
delete from submissions
where challenge_id is not NULL


update submissions SET
(challenge_id, score) = 
	(select 100+ num%10, trunc(random()*500)
	from generate_series(1,400,1) as num
	where sub_id = num)

select * from hackers


-- The total score of a hacker is the sum of their maximum scores for all of the challenges. 
-- Write a query to print the hacker_id, name, and total score of the hackers ordered by the 
-- descending score. If more than one hacker achieved the same total score, then sort the 
-- result by ascending hacker_id. Exclude all hackers with a total score of 0 from your result.

-- For each hacker, find max score on each challenge
-- If they did not make any submissions for a challenge, score is 0
-- Don't care about submission date
-- After finding hacker_id, join to hackers to get name
-- Sort as specified, but exclude hackers with score of 0

-- For every combination of hackers and challenges, find max score
with cte_max as(
	select hacker_id, challenge_id,  max(score) as max_scores
	from submissions
	group by hacker_id, challenge_id
	ORDER by hacker_id, challenge_id
	)
select c.hacker_id, h.name, sum(max_scores) as total_score
from cte_max c
inner join hackers h on h.hacker_id = c.hacker_id
group by c.hacker_id, h.name
having sum(max_scores) > 0
order by 3 desc, 1 asc

-- 3	"Name3"	4162
-- 5	"Name5"	3959
-- 1	"Name1"	3899

select * from
submissions
where hacker_id=1 and challenge_id = 101

-- Make hacker_id 1 have same score as Hacker_id 5
update submissions
set score = 311
where sub_id = 151

-- Add a hacker with 0 score and null score to confirm they are excluded
insert into submissions
(hacker_id, submission_date, challenge_id,score)
values
(11,'2016-03-09',101,0),
(12,'2016-03-09',101,NULL)

insert into hackers
(hacker_id,name)
values
(11, 'Name11'),
(12, 'Name12')
