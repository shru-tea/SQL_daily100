/*
Assume you're given a table containing data on Amazon customers and their spending on 
products in different category, write a query to identify the top two highest-grossing 
products within each category in the year 2022. The output should include the category, 
product, and total spend.
*/


SELECT category, product, total_spend 
FROM (
SELECT 
category, product,
SUM(spend) as total_spend,
DENSE_RANK() OVER(PARTITION BY category ORDER BY SUM(spend) DESC) as rnk
FROM product_spend
WHERE transaction_date >= '2022-01-01' AND transaction_date < '2023-01-01'
GROUP BY 1,2
) t 
WHERE rnk <=2;

/*
Seems like row_number() should be used rather than dense_rank() or even rank()--
after all if we are looking for the top two highest grossing products, then in the 
case of ties, rank() and dense_rank() might yield 3 or 4 highest grossing products,
 rather than the top 2. Row_number() would result in exactly 2 products.
*/

SELECT
category,
product,
total_spend
FROM (
SELECT 
category,
product,
SUM(spend) AS total_spend,
ROW_NUMBER() OVER(PARTITION BY category ORDER BY SUM(spend) DESC) as rnk
FROM table_ddl.ProductSpend 
GROUP BY 1,2) t
WHERE rnk BETWEEN 1 AND 2