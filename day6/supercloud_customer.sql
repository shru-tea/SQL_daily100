/*
A Microsoft Azure Supercloud customer is defined as a customer who has purchased at least one product from every product category listed in the products table.

Write a query that identifies the customer IDs of these Supercloud customers.
*/

SELECT 
c.customer_id,
COUNT(DISTINCT p.category_id) as total_categories
FROM customer_contracts c JOIN products p 
ON c.product_id = p.product_id
GROUP BY c.customer_id 
HAVING COUNT(DISTINCT p.category_id) = (SELECT COUNT(DISTINCT category_id) FROM products);