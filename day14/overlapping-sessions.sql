-- overlapping sessions

-- overlapping sessions

WITH gaps AS (
SELECT
*,
LAG(session_end) OVER(PARTITION BY user_id ORDER BY session_start,session_end)
AS prev_session_end,
CASE 
	WHEN session_start <= LAG(session_end) OVER(PARTITION BY user_id ORDER BY session_start,session_end)
	THEN 0 
	ELSE 1
END AS continuous_session
FROM table_ddl.sessions),

islands AS (
SELECT
*,
SUM(continuous_session) OVER(PARTITION BY user_id ORDER BY session_start,session_end) AS
islands
FROM
gaps),

streaks AS (
SELECT
user_id,
MIN(session_start) AS session_start_date,
MAX(session_end) AS session_end_date
FROM islands
GROUP BY user_id,islands)

SELECT
user_id,
SUM(session_end_island - session_start_island) AS total_mins
FROM streaks
GROUP BY 1

