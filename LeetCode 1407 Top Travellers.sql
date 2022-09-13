set search_path to data_sci

CREATE table rides (
id integer PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
user_id integer,
distance INTEGER

)

insert into rides
(user_id, distance)
VALUES
(1       ,120),
(2       ,317),
(3       , 222 ),
(4       ,100   ),
(5     , 222 )



select * from salesperson;
select * from rides;

-- Order by Distance descending.
-- If two users traveled the same distance, order by names Ascending
-- Note: Order By can have multiple criteria.
select sp.name,r.distance
from salesperson sp
inner join rides r on sp.sales_id = r.user_id
order by r.distance DESC, name asc



