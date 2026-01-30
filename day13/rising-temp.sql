SELECT 
w1.*,w2.*
FROM Weather w1 
JOIN Weather w2 
ON w1.recordDate - w2.recordDate + INTERVAL '1 day'
WHERE w1.temperature > w2.temperature;


SELECT id
FROM 
(
SELECT
*,
LAG(recordDate) OVER(ORDER BY recordDate) AS prevDate,
LAG(temperature) OVER(ORDER BY recordDate) AS prevTemp
FROM Weather) t 
WHERE recordDate = prevDate+INTERVAL '1 day'
AND temperature > prevTemp