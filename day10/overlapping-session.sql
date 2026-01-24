--Calculate total active time per user.
--Overlapping sessions must not be double counted.

--Calculate total active time per user.
--Overlapping sessions must not be double counted.

WITH gaps AS (
SELECT
ROW_NUMBER() OVER(ORDER BY user_id, session_start,session_end) AS rn,
*,
LAG(session_end) OVER(PARTITION BY user_id ORDER BY session_start,session_end) 
AS prev_session_end,
CASE WHEN 
	session_start <= LAG(session_end) OVER(PARTITION BY user_id ORDER BY session_start,session_end)
	THEN 0
	ELSE 1
END AS gaps
FROM table_ddl.sessions),

streaks AS (
SELECT
*,
SUM(gaps) OVER(PARTITION BY user_id ORDER BY session_start , session_end)
AS islands
FROM gaps),

start_end AS (
SELECT
user_id,
MIN(session_start) AS session_start_island,
MAX(session_end) AS session_end_island
FROM streaks
GROUP BY user_id,islands)

SELECT 
user_id,
SUM(session_end_island - session_start_island) AS total_mins
FROM start_end
GROUP BY user_id;