/*
Use COALESCE to find the first discount available on a product.
Given a table of products, prices and discounts, apply the first discount available.
If none are available, apply default discount of 0.1.
COALESCE is an easy way to do that if the table has NULL values when discount is not available
since it returns the fist non-NULL value in the list.
*/



set search_path to data_sci;

create table products_and_prices
(id int generated by default as identity,
product text,
price FLOAT,
discount1 FLOAT,
discount2 FLOAT);

INSERT into products_and_prices
(product, price, discount1, discount2)
VALUES
('p1',123.4, 1.0, 0.5),
('p2',234.5, 1.0,NULL),
('p3',345.5,NULL, .75),
('p4', 456.7,NULL,NULL);

select product, price, price - COALESCE(discount1,discount2, .1) discounted_price
from products_and_prices;
