-- Find matching hosts and guests pairs in a way that they are both of the same gender and nationality.
-- Output the host id and the guest id of matched pair.

select distinct h.host_id, g.guest_id
from airbnb_hosts h
cross join airbnb_guests g
where h.nationality = g.nationality
and h.gender = g.gender
order by h.host_id