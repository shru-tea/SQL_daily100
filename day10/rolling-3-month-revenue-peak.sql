--For each region, find the 3-month rolling window with the highest total revenue.

--For each region, find the 3-month rolling window with 
--the highest total revenue.(SUM FIRST)

-- each row contains - region, window_start,window_end, rolling_3_day_revenue
--per region per month - total revenue first

WITH monthly_rollup AS
(
SELECT
region,
DATE_TRUNC('month',sale_date) AS month,
SUM(revenue) AS total_sales
FROM table_ddl.sales
GROUP BY 1,2),

rolling_sum AS(
SELECT
*,
SUM(total_sales) OVER(PARTITION BY region ORDER BY month
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS three_month_rolling_sum--,
--COUNT(*) OVER(PARTITION BY region ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
--AS window_size
FROM monthly_rollup),

ranking AS (
SELECT
*,
DENSE_RANK() OVER(PARTITION BY region ORDER BY three_month_rolling_sum DESC) AS rnk
FROM rolling_sum
--WHERE window_size=3
)

SELECT
region,
month - INTERVAL '2 months' AS window_start_month,
month AS window_end_month,
three_month_rolling_sum AS rolling_3_month_revenue
FROM ranking
WHERE rnk = 1