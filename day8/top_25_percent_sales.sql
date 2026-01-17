-- SELECT top 25% of customer sales in the last year

WITH customer_data AS (
SELECT 
customer_id,
SUM(purchase_amount) AS customer_sales
FROM table_ddl.customer_sales
WHERE order_date >='2023-01-01' AND order_date < '2024-01-01'
GROUP BY customer_id ) ,

percent_ranking AS (SELECT 
customer_id,
PERCENT_RANK() OVER(ORDER BY customer_sales DESC) as perc
FROM customer_data)

SELECT 
customer_id,
perc as percent_ranks
FROM percent_ranking
WHERE perc>=0.25