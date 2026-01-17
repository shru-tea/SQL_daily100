-- using window function

SELECT 
DISTINCT
product_name,
(original_price - black_friday_price) * 100 / original_price AS black_friday_discount
FROM (
SELECT 
*,
MAX(CASE WHEN price_date = '2023-01-01' THEN price END) OVER(PARTITION BY product_name) AS original_price,
MAX(CASE WHEN price_date = '2023-11-25' THEN price END) OVER(PARTITION BY product_name) AS black_friday_price
FROM table_ddl.black_friday_sales) t
WHERE black_friday_price IS NOT NULL;

-- without using window function
SELECT
product_name,
(original_price-black_friday_price)*1.0/original_price * 100 AS bfd
FROM
(SELECT 
product_name,
MAX(CASE WHEN price_date = '2023-01-01' THEN price END) AS original_price,
MAX(CASE WHEN price_date = '2023-11-25' THEN price END) AS black_friday_price
FROM table_ddl.black_friday_sales
GROUP BY product_name) t
WHERE black_friday_price is NOT NULL