--Find the maximum number of concurrent users at any time.

--transpose rows into columns because login - +1 and logout - -1
WITH delta AS (
SELECT login AS time, 1 AS effective_user
FROM table_ddl.login_details
UNION ALL
SELECT logout AS time, -1 AS effective_user
FROM table_ddl.login_details
),

--running sum to calculate the no of effective_users
effective AS (
SELECT
*,
SUM(effective_user) OVER(ORDER BY time,effective_user) AS total_effective_user
FROM
delta)

SELECT MAX(total_effective_user) AS max_concurrent_users
FROM effective