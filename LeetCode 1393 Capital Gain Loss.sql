set search_path to data_sci;

drop  type ops
CREATE type ops as enum('Buy', 'Sell');


drop table stocks

CREATE TABLE Stocks (
stock_name varchar,
operation    ops   ,
operation_day int    ,
price         int 
);

insert into stocks
values
('Leetcode','Buy',1             ,1000),
('Corona Masks','Buy',2             ,10),
('Leetcode','Sell',5             , 9000),
('Handbags','Buy',17           , 30000),
('Corona Masks','Sell',3           ,1010),
('Corona Masks','Buy',4           , 1000),
('Corona Masks','Sell',5           , 500),
('Corona Masks','Buy',6            , 1000),
('Handbags','Sell',29           , 7000),
('Corona Masks','Sell',10          , 10000)

select stock_name, sum(price * -1) 
from stocks
where operation = 'Buy'
group by stock_name

select stock_name, sum(price) 
from stocks
where operation = 'Sell'
group by stock_name


order by operation_day asc


-- Write an SQL query to report the Capital gain/loss for each stock.
-- The Capital gain/loss of a stock is the total gain or loss after buying 
-- and selling the stock one or many times.

-- Cap gain sum sell prices and subtract buy prices

-- Sum all the Buys and Sells. Then compute diff
select total_buy_per_stock.stock_name, 
	(total_sell_per_stock.sell_sum - total_buy_per_stock.buy_sum) as capital_gain_loss
FROM
(select stock_name, sum(price) as buy_sum
	from stocks
	where operation = 'Buy'
	group by stock_name) as total_buy_per_stock

inner join
(select stock_name, sum(price) as sell_sum
	from stocks
	where operation = 'Sell'
	group by stock_name) as total_sell_per_stock
	on total_buy_per_stock.stock_name = total_sell_per_stock.stock_name
	

-- Even more straight forward using a Case
select stock_name, 
	sum(
		case
			when operation = 'Buy' THEN
				 (price * -1)
			else  price
		end 
		) as capital_gain_loss

FROM stocks
group by stock_name



