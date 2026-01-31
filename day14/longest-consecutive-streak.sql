--Find the longest consecutive-day login streak for each user.
-- first, find gaps

WITH gaps AS (
SELECT
*,
LAG(login_date) OVER(PARTITION BY user_id ORDER BY login_date) AS prev_date,
CASE WHEN login_date = LAG(login_date) OVER(PARTITION BY user_id ORDER BY login_date) 
+ INTERVAL '1 DAY' THEN 0 ELSE 1 END AS gaps
FROM table_ddl.login),

islands AS (
SELECT
*,
SUM(gaps) OVER(PARTITION BY user_id ORDER BY login_date) AS island
FROM gaps),

 streaks AS (
SELECT
user_id,island,
COUNT(*) AS streak_len
FROM islands
GROUP BY user_id, island)

SELECT
user_id, MAX(streak_len)
FROM streaks
GROUP BY 1