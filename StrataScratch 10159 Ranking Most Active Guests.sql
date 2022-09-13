-- Rank guests based on the number of messages they've exchanged with the hosts. Guests with the same number of 
-- messages as other guests should have the same rank. Do not skip rankings if the preceding rankings are identical.
-- Output the rank, guest id, and number of total messages they've sent. Order by the highest number of total messages first.

-- Use dense_rank since no skipping is desired

select 
dense_rank() over (order by sum(n_messages) desc) ranking,
id_guest, sum(n_messages) cnt_msgs
from airbnb_contacts 
group by id_guest
order by cnt_msgs desc