--output the users most recent transaction date user id and the number 
-- of products, sorted in chronological order
SELECT 
transaction_date,
user_id,
COUNT(product_id) AS purchased_count
FROM
(SELECT
*,
DENSE_RANK() OVER(PARTITION BY user_id ORDER BY transaction_date DESC) as rnk
FROM table_ddl.transactions) t 
WHERE rnk = 1
GROUP BY 1,2
ORDER BY 1;