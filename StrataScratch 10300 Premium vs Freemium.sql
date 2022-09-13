set search_path to data_sci

drop table if exists ms_user_dimension;
create table ms_user_dimension (
	user_id int,
	acc_id int
	 );
	 


drop table if exists ms_acc_dimension;
create table ms_acc_dimension (
	acc_id int,
	paying_customer text
);

drop table if exists ms_download_facts;
CREATE TABLE ms_download_facts (
date date,
user_id int,
	downloads int
);



-- Find the total number of downloads for paying and non-paying users by date. 
-- Include only records where non-paying customers have more downloads than paying customers. 
-- The output should be sorted by earliest date first and contain 3 columns date, non-paying 
-- downloads, paying downloads.

SELECT count(distinct(user_id)), count(distinct(acc_id))
from ms_user_dimension
--100	42

SELECT count(distinct(acc_id))
from ms_acc_dimension
-- 51
-- i.e. some accounts have not downloaded

SELECT count(distinct(user_id))
from ms_download_facts
-- 100

with cte_cust_type as 
(select d.date, d.user_id, d.downloads,
	(select a.paying_customer
	 	from ms_acc_dimension a
		inner join ms_user_dimension u on u.acc_id = a.acc_id
		where d.user_id = u.user_id) as paying_cust
from ms_download_facts d
),
date_group as(
	select c1.date,
	sum(case when c1.paying_cust='no' then c1.downloads end) as non_paying,
    sum(case when c1.paying_cust='yes' then c1.downloads end) as paying
	from cte_cust_type c1
	group by c1.date
)
select * 
from date_group
where non_paying > paying
order by date asc

-------------------------------------------------------------
create TEMPORARY table aa_temp (
val1 int,
val2 int
)

insert into aa_temp
values
(1, 2),
(3, 4),
(Null, 5),
(6, Null),
(Null, Null),
(7 ,8);

select * from aa_temp

-- Use ANY to count rows that have any Null
-- Use ALL to count rows the are all Null
select count(*)
from aa_temp
where True = ALL(
	ARRAY[val1 is Null, val2 is Null])
	
