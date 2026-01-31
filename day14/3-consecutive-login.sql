--first method - self join

SELECT
DISTINCT l1.user_id
FROM table_ddl.login l1
JOIN table_ddl.login l2
ON l1.user_id = l2.user_id
AND l2.login_date = l1.login_date+INTERVAL '1 day'
JOIN table_ddl.login l3
ON l1.user_id = l3.user_id
AND l3.login_date = l1.login_date + INTERVAL '2 days'

-- second method - login_date - ROW_NUMBER()
WITH grp AS (
SELECT
*,
(ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY login_date) || 'days') ::interval AS rno,
login_date - (ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY login_date)||'days')::interval
AS diff
FROM table_ddl.login)

SELECT
user_id
FROM grp
GROUP BY user_id
HAVING COUNT(diff) >=3


-- third method - gaps and islands
--first see the prev_date, then calculate the streaks (not gaps),
--then do a running sum to find gaps
WITH streaks AS (
SELECT
*,
LAG(login_date) OVER(PARTITION BY user_id ORDER BY login_date) AS prev_date,
CASE WHEN login_date = LAG(login_date) OVER(PARTITION BY user_id ORDER BY login_date)
+ INTERVAL '1 day' THEN 0 ELSE 1 END AS streaks
FROM table_ddl.login),

 gaps AS (
SELECT
*,
SUM(streaks) OVER(PARTITION BY user_id ORDER BY login_date) AS grp_no
FROM streaks)

SELECT
user_id
FROM gaps
GROUP BY user_id,grp_no
HAVING COUNT(grp_no) >=3


-- if duplicate login dates exist, use DISTINCT in the CTEs
WITH streaks AS (
SELECT
DISTINCT
*,
LAG(login_date) OVER(PARTITION BY user_id ORDER BY login_date) AS prev_date,
CASE WHEN login_date = LAG(login_date) OVER(PARTITION BY user_id ORDER BY

    login_date)
+ INTERVAL '1 day' THEN 0 ELSE 1 END AS streaks
FROM table_ddl.login),

 gaps AS (
SELECT
*
,
SUM(streaks) OVER(PARTITION BY user_id ORDER BY login_date) AS grp
FROM streaks)
SELECT
user_id
FROM gaps
GROUP BY user_id,grp
HAVING COUNT(grp) >=3; 