-- Write your PostgreSQL query statement below
--moving average

--first aggregate for multiple dates

WITH roundup AS (
SELECT
visited_on,
SUM(amount) AS total_amount
FROM Customer
GROUP BY visited_on)

SELECT
visited_on,
amount1 AS amount,
avg_amount AS average_amount
FROM (
SELECT
visited_on,
SUM(total_amount) OVER(ORDER BY visited_on RANGE BETWEEN INTERVAL '6 DAYS' PRECEDING
AND CURRENT ROW) AS amount1,
ROUND(AVG(total_amount) OVER(ORDER BY visited_on RANGE BETWEEN INTERVAL '6 DAYS' PRECEDING
AND CURRENT ROW),2) AS avg_amount,
COUNT(*) OVER(ORDER BY visited_on RANGE BETWEEN INTERVAL '6 DAYS' PRECEDING AND CURRENT ROW) AS cnt
FROM 
roundup ) t
WHERE cnt = 7


--------------
--moving average of how much the customer paid in a seven days window
-- since it is a moving average for past 7 days we have to make sure there are 
-- no duplicate dates

WITH roundup AS (
SELECT
visited_on,
SUM(amount) AS total_amount
FROM table_ddl.customer_info
GROUP BY visited_on
)
,
moving_avg AS (
SELECT
*,
ROUND(AVG(total_amount) OVER(ORDER BY visited_on RANGE BETWEEN INTERVAL '6 days' PRECEDING 
AND CURRENT ROW),2) AS moving_7_day_avg,
COUNT(*) OVER(ORDER BY visited_on RANGE BETWEEN INTERVAL '6 days' PRECEDING AND CURRENT ROW) AS cnt
FROM
roundup)

SELECT
visited_on,
total_amount AS amount,
moving_7_day_avg AS average_amount
FROM moving_avg
WHERE cnt = 7