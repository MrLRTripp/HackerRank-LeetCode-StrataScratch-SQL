set search_path to data_sci

CREATE TABLE facebook_friends (
user1 int,
user2 int
)


-- Find the popularity percentage for each user on Meta/Facebook. The popularity percentage 
-- is defined as the total number of friends the user has divided by the total number of users 
-- on the platform, then converted into a percentage by multiplying by 100.
-- Output each user along with their popularity percentage. Order records in ascending order 
-- by user id. The 'user1' and 'user2' column are pairs of friends.



with distinct_users as (
	select f1.user1 as fb_user
	from facebook_friends f1
	union
	select f2.user2 as fb_user
	from facebook_friends f2
	),
pairs as (	
	select array[user1,user2] as fb_pair
	from facebook_friends
	),
friend_count as (
	select du.fb_user, 
	sum(case when du.fb_user = any(fb_pair) then 1 else 0 end ) as friend_cnt
	from distinct_users du
	cross join pairs
	group by du.fb_user
	)
select fc.fb_user, 
 round(((fc.friend_cnt::real/
	   (select count(fb_user) from distinct_users))*100)::numeric,2) as popularity_percentage
from friend_count fc


--------------------------------------
-- The instructor solution is better
-- Create the union of pairs and then count and group
WITH users_union AS
  (SELECT user1,
          user2
   FROM facebook_friends
   UNION 
   SELECT user2 AS user1,
                user1 AS user2
   FROM facebook_friends)
SELECT user1,
   count(*)::float /
   (SELECT count(DISTINCT user1) FROM users_union)
   *100 AS popularity_percent
FROM users_union
GROUP BY 1
ORDER BY 1

