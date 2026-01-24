/*Return customers whose first and last order dates are in different months.*/

SELECT customer_id FROM 
(SELECT customer_id,
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date
FROM Orders 
GROUP BY customer_id ) t
WHERE EXTRACT(YEAR FROM first_order_date) <> EXTRACT(YEAR FROM last_order_date)
OR EXTRACT(MONTH FROM first_order_date) <> EXTRACT(MONTH FROM last_order_date);

/*
LOGIC - 
the order shouldnt be in the same year and if it is then it should not be in the same month
*/