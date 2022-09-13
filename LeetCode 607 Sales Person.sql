set search_path to data_sci

create table SalesPerson(
sales_id   int,
name   text,
salary   int,
commission_rate int,
hire_date    date
	)
	
	
CREATE TABLE Company(
com_id  int,
name   varchar,
city    varchar)


CREATE TABLE Orders (
order_id     int,
order_date   date ,
com_id      int  ,
sales_id     int  ,
amount      int )


insert into SalesPerson
VALUES
(1        ,'John' , 100000 , 6              , '4/1/2006'),
(2       , 'Amy'  , 12000  , 5             , '5/1/2010'  ),
(3        , 'Mark' , 65000 , 12            , '12/25/2008' ),
(4        , 'Pam'  , 25000  , 25             , '1/1/2005'  ),
(5        , 'Alex' ,5000  , 10             , '2/3/2007' );


INSERT into Company
VALUES
(1      , 'RED','Boston'),
( 2      , 'ORANGE','New York'),
(3     ,'YELLOW','Boston'),
(4      ,'GREEN','Austin') 

INSERT into Orders 
VALUES
(1        ,'1/1/2014', 3     , 4      , 10000 ),
(2        ,'2/1/2014', 4     , 5     , 5000   ),
(3       ,'3/1/2014', 1      , 1      , 50000  ),
(4       ,'4/1/2014', 1     , 4        , 25000)

-- Find the sales people who did not have any sales with company RED
-- Gets tricky because Pam has sales with RED and YELLOW so should be excluded
-- Amy and Mark have no sales at all
-- The subquery finds those that have RED sales, and then we exclude them
select  s.Name
FROM SalesPerson s
where s.sales_id not in 
	(select s2.sales_id
	FROM SalesPerson s2
	inner join Orders o on s2.sales_id = o.sales_id
	inner join Company cp on cp.com_id = o.com_id
	where cp.name = 'RED')


