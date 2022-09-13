set search_path to data_sci


truncate table fb_friend_requests
create table fb_friend_requests(
user_id_sender text,
user_id_receiver text,
date date,
action text
	
	)

select count(*) from fb_friend_requests
limit 10

-- What is the overall friend acceptance rate by date? Your output should have the rate of 
-- acceptances by the date the request was sent. Order by the earliest date to latest.
-- Assume that each friend request starts by a user sending (i.e., user_id_sender) a 
-- friend request to another user (i.e., user_id_receiver) that's logged in the table 
-- with action = 'sent'. If the request is accepted, the table logs action = 'accepted'. 
-- If the request is not accepted, no record of action = 'accepted' is logged.

with cte_sent as
(select date,user_id_sender, user_id_receiver,count(action) cnt
from fb_friend_requests
where action = 'sent'
group by date, user_id_sender,user_id_receiver),
cte_accept as (
select user_id_sender, user_id_receiver,count(action) cnt
from fb_friend_requests
where action = 'accepted'
group by user_id_sender,user_id_receiver)

select cte_sent.date, 
(sum(cte_accept.cnt)::real/
 sum(cte_sent.cnt)) acceptance_rate
from cte_sent
left join cte_accept
on cte_sent.user_id_sender = cte_accept.user_id_sender
group by cte_sent.date
order by cte_sent.date ASC


insert into fb_friend_requests
VALUES
('ad4943sdz','bob', '2020-01-04', 'sent'),
('ad4943sdz','bob', '2020-01-10', 'accepted')