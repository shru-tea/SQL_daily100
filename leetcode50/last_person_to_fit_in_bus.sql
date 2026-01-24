-- Write your PostgreSQL query statement below
SELECT person_name 
FROM(
SELECT
*,
SUM(weight) OVER(ORDER BY turn) AS rolling_sum
FROM Queue) t
WHERE rolling_sum <= 1000
ORDER BY turn DESC 
LIMIT 1