set search_path to data_sci

CREATE table facebook_web_log (
user_id integer,
dtime timestamp,
action text
)


select * from facebook_web_log
where user_id = 0
and action in ('page_load','page_exit')
order by dtime asc


with mx as(
	select user_id, dtime::date l_day, max(dtime) mxl
	from facebook_web_log
	where action = 'page_load'
	group by 1,2),
mn as(
	select fl.user_id, fl.dtime::date e_day, min(fl.dtime) mne
	from facebook_web_log fl
	where action = 'page_exit'
	group by 1,2)

--select mx.user_id, mx.l_day, (mn.mne - mx.mxl) as session_duration
--from mx
--inner join mn on mx.l_day = mn.e_day and  mx.user_id = mn.user_id
--where mn.mne > mx.mxl

select mx.user_id, avg(mn.mne - mx.mxl) as session_duration
from mx
inner join mn on mx.l_day = mn.e_day and  mx.user_id = mn.user_id
group by 1



