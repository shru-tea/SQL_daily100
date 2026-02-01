--Find customers who made purchases on 3 consecutive days
--Same-day multiple purchases allowed.

-- SINCE SAME DAY PURHCASES - DEDUPLICATION

-- deduplication
WITH dedup AS (
SELECT DISTINCT
customer_id, order_date
FROM table_ddl.orders_one
),

gaps AS (
SELECT
*,
LAG(order_date) OVER(PARTITION BY customer_id ORDER BY order_date) AS prev_order_date,
CASE 
	WHEN order_date = LAG(order_date) OVER(PARTITION BY customer_id ORDER BY order_date) 
	+ 1
	THEN 0 
	ELSE 1
END AS continuous_orders
FROM
dedup),

islands AS (
SELECT
*,
SUM(continuous_orders) OVER(PARTITION BY customer_id ORDER BY order_date) AS 
islands
FROM gaps)

SELECT
customer_id
FROM islands
GROUP BY customer_id,islands
HAVING COUNT(*) >=3
