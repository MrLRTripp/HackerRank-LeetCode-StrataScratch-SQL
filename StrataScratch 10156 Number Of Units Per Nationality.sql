-- Find the number of apartments per nationality that are owned by people under 30 years old.
-- Output the nationality along with the number of apartments.
-- Sort records by the apartments count in descending order.

-- There are multiple duplicate records in airbnb_hosts so you have to count distinct units
-- If there weren't duplicate records, distinct is not needed

select h.nationality, count(distinct u.unit_id) apt_count

from airbnb_hosts h
inner join airbnb_units u on u.host_id = h.host_id
where u.unit_type = 'Apartment'
and h.age < 30
group by h.nationality
order by apt_count desc