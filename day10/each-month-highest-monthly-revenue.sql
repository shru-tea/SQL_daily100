--For each region, find the month with the highest total revenue.
-- each row -> per region per month

WITH monthly_rollup AS
(
SELECT
region,
--TO_CHAR(sale_date,'YYYY-MM') AS month,
DATE_TRUNC('month', sale_date) AS date_month,
SUM(revenue) AS total_revenue
FROM table_ddl.sales
GROUP BY region, DATE_TRUNC('month', sale_date))

SELECT
region, date_month, total_revenue
FROM
(
SELECT
*,
DENSE_RANK() OVER(PARTITION BY region ORDER BY total_revenue DESC) AS rnk
FROM monthly_rollup) t
WHERE rnk = 1