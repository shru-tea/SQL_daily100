/*
Assume you're given tables with information on Snapchat users, including their ages and time spent sending and opening snaps.

Write a query to obtain a breakdown of the time spent sending vs. opening snaps as a percentage of total time spent on these activities grouped by age group. Round the percentage to 2 decimal places in the output.

Notes:

Calculate the following percentages:
time spent sending / (Time spent sending + Time spent opening)
Time spent opening / (Time spent sending + Time spent opening)
To avoid integer division in percentages, multiply by 100.0 and not 100.

*/


WITH cte AS (
  SELECT 
  user_id,
    ROUND(time_spent_sending * 100.0 / (time_spent_sending + time_spent_opening),2) AS send_perc,
    ROUND(time_spent_opening * 100.0 / (time_spent_sending + time_spent_opening),2) AS open_perc
    FROM
    (
SELECT 
user_id,
SUM(CASE 
  WHEN activity_type = 'open' THEN time_spent ELSE 0 END) AS time_spent_opening,
SUM(CASE WHEN activity_type = 'send' THEN time_spent ELSE 0 END ) AS
time_spent_sending
FROM activities
GROUP BY user_id ) t 
)

SELECT b.age_bucket,a.send_perc, a.open_perc
FROM cte a 
JOIN age_breakdown b 
ON a.user_id = b.user_id
ORDER BY b.age_bucket