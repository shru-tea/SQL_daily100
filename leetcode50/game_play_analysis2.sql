/*
https://leetcode.com/problems/game-play-analysis-iv/description/?envType=problem-list-v2&envId=m8baczxh
*/


-- Write your PostgreSQL query statement below

-- DAY AFTER THE DAY THEY FIRST LOGGED IN

-- first need to find out the first day each player logged in
/*
SELECT
player_id,
MIN(event_date) AS first_logged
FROM Activity
GROUP BY player_id
*/
SELECT
ROUND(COUNT(DISTINCT CASE WHEN diff=1 AND prev_login = first_login THEN player_id END )*1.0 /
COUNT(DISTINCT player_id),2) AS fraction
FROM (
SELECT
*,
MIN(event_date) OVER(PARTITION BY player_id) AS first_login,
LAG(event_date) OVER(PARTITION BY player_id ORDER BY event_date) AS prev_login,
event_date - LAG(event_date) OVER(PARTITION BY player_id ORDER BY event_date) AS diff
FROM (
    -- to remove de duplication
SELECT DISTINCT player_id,event_date FROM Activity) a
) t


WITH first_login AS (
    SELECT
        player_id,
        MIN(event_date) AS first_login
    FROM Activity
    GROUP BY player_id
)
SELECT
    ROUND(
        COUNT(*) * 1.0 / (SELECT COUNT(DISTINCT player_id) FROM Activity),
        2
    ) AS fraction
FROM first_login f
JOIN Activity a
  ON a.player_id = f.player_id
 AND a.event_date = f.first_login + 1;