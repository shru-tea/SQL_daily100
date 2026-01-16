/*Find the products that have a price higher than the average price
of all products*/

SELECT product_id, product_name, price
FROM products   
WHERE price > (SELECT AVG(price) FROM products);

-- OR 

SELECT 
*
FROM (
SELECT product_id,
product_name,
price,
AVG(price) OVER() AS avg_sales_all_products
FROM products ) t 
WHERE price > avg_sales_all_products;