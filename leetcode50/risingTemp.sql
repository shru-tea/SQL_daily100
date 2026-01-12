/*Write a solution to find all dates' id with 
higher temperatures compared to its previous dates (yesterday).
*/

-- Write your PostgreSQL query statement below
SELECT id FROM (
SELECT 
id,
recordDate,
temperature,
LAG(temperature) OVER(ORDER BY recordDate) AS previous_temp,
LAG(recordDate) OVER(ORDER BY recordDate) AS previous_day,
CASE 
    WHEN temperature > LAG(temperature) OVER(ORDER BY recordDate) THEN 'Y' ELSE 'N' END AS temp_diff
    FROM Weather
) t 
WHERE temp_diff = 'Y'
AND recordDate = previous_day + INTERVAL '1 day';