set search_path to data_sci

create table activity (
	user_id       int,
	session_id     int,
	activity_date  date,
	activity_type  TEXT
	)
	
	
insert into activity
VALUES
( 1       , 1          , '2019-07-20'    , 'open_session') ,
(1       , 1          , '2019-07-20'    , 'scroll_down')    ,
( 1       , 1          , '2019-07-20'    , 'end_session')    ,
(2       , 4          , '2019-07-20'    , 'open_session')   ,
(2       , 4          , '2019-07-21'    , 'send_message')   ,
(2       , 4          , '2019-07-21'    , 'end_session')    ,
(3       , 2          , '2019-07-21'    , 'open_session')   ,
(3       , 2          , '2019-07-21'    , 'send_message')   ,
( 3       , 2          , '2019-07-21'    , 'end_session')    ,
(4       , 3          , '2019-06-25'    , 'open_session')   ,
(4       , 3          , '2019-06-25'    , 'end_session');

select * from activity
ORDER by activity_date ASC

-- Find the daily active user count for a period of 30 days ending 2019-07-27 inclusively. 
-- A user was active on someday if they made at least one activity on that day.
-- Have to explicity cast the string to a date before subtracting 30 in this situation
-- otherwise it did not know how to perform the subtraction.
select activity_date, count(user_id)
from (select distinct 	user_id , session_id, activity_date
	from activity) distinct_activity
group by activity_date
having activity_date between  ('2019-07-27'::date - 30) and '2019-07-27'


-- From Leet. 
SELECT
    activity_date as day,
    count(distinct user_id) as active_users
FROM
    Activity
WHERE activity_date <= '2019-07-27' and activity_date >= '2019-06-28'
GROUP BY activity_date;
