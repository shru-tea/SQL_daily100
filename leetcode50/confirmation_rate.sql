/*
https://leetcode.com/problems/confirmation-rate/description/?envType=study-plan-v2&envId=top-sql-50
*/

-- what does 1 row represent = per user id, how many action was confirmed / total no of requested messages
--Confirmations has many rows per user
--Output has 1 row per user

SELECT 
user_id,
ROUND(confirmed_count_avg,2) AS confirmation_rate
FROM 
(
SELECT
s.user_id,
AVG(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END) AS confirmed_count_avg
FROM Signups s
LEFT JOIN Confirmations c
ON s.user_id = c.user_id
GROUP BY s.user_id
) t

