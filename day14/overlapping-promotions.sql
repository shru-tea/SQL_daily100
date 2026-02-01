--Find products that had overlapping promotions.

--window functions
--step 1 : LAG() end date and compare with start date

WITH gaps AS (
SELECT
*,
LAG(end_date) OVER(PARTITION BY product_id ORDER BY start_date,end_date) 
AS prev_end_date
FROM table_ddl.promotions)

SELECT DISTINCT product_id
FROM gaps
WHERE prev_end_date IS NOT NULL 
AND start_date <= prev_end_date

-- self join

SELECT
p1.*,p2.*
FROM table_ddl.promotions p1
JOIN table_ddl.promotions p2
ON p1.product_id = p2.product_id
WHERE p1.start_date <= p2.end_date
AND p1.start_date < p2.start_date
AND p2.start_date <= p1.end_date