-- Assume you are given the following tables on Walmart transactions and products. 
-- Find the top 3 products that are most frequently bought together (purchased in the same transaction).

-- Output the name of product #1, name of product #2 and number of combinations in descending order..

-- The key here is to find all product pairs for each transaction. Since the pair <p1,p2> is the same as <p2,p1>
-- we arbitrarily order the products t1.product_id > t2.product_id so we only get unique pairs.
-- Then we can group by the product names and count the pairs 

SELECT 
p1.product_name, p2.product_name,
count(concat(p1.product_name, '_', p2.product_name)) num

FROM transactions t1
inner JOIN transactions t2 on t1.transaction_id = t2.transaction_id
inner join products p1 on t1.product_id = p1.product_id
inner join products p2 on t2.product_id = p2.product_id
where t1.product_id > t2.product_id
GROUP BY p1.product_name, p2.product_name
ORDER BY num DESC
limit 3