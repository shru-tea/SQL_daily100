-- Rank customers based on their total sales and return those with rank 1

SELECT
*,
DENSE_RANK() OVER(ORDER BY total_sales DESC) as sales_rank
FROM (
    SELECT
customer_id,
SUM(Sales) AS total_sales
FROM Orders 
GROUP BY customer_id
) t
WHERE sales_rank = 1;