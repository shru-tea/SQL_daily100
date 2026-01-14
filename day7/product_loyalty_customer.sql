/*
customer_orders
- customer_id
- order_id
- order_date
- product_id

products
- product_id
- category
Prompt
Find the list of customer_id who have purchased at least one product from every category in the last 6 months.
Sort the output by customer_id.

*/

SELECT
c.customer_id,
--COUNT(DISTINCT p.product_id) AS categories_purchased
FROM customer_orders c JOIN products p 
ON c.product_id = p.product_id 
WHERE c.order_date >= NOW() - INTERVAL '6 Month'
GROUP BY c.customer_id
HAVING COUNT(DISTINCT p.category) = (SELECT COUNT(DISTINCT category) FROM products)
ORDER BY c.customer_id;