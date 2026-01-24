SELECT
customer_id,
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date,
SUM(amount) AS total_spend
FROM table_ddl.orders_dates 
GROUP BY customer_id;

-- with window functions
