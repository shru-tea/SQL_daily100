--n consecutive days

--without window functions
-- N consecutive days login

--without window functions
--row contains 3 consecutive days per user

SELECT
l1.user_id,l1.login_date AS ld1, l2.login_date AS ld2, l3.login_date AS ld3
FROM table_ddl.logins l1
JOIN table_ddl.logins l2
ON l1.user_id = l2.user_id
AND l2.login_date = l1.login_date + INTERVAL '1 DAY'
JOIN table_ddl.logins l3
ON l1.user_id = l3.user_id
AND l3.login_date = l1.login_date + INTERVAL '2 days'

-- with window functions
SELECT
user_id
FROM (
SELECT
*,
ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY login_date) AS rno,
login_date - (ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY login_date) || 'days')::interval AS diff
FROM table_ddl.logins) t 
GROUP BY user_id, diff
HAVING COUNT(diff) >=3
ORDER BY user_id

WITH t AS (
SELECT
*,
LAG(login_date) OVER(PARTITION BY user_id ORDER BY login_date),
CASE WHEN 
	login_date = LAG(login_date) OVER(PARTITION BY user_id ORDER BY login_date)
	+ INTERVAL '1 day' THEN 0 ELSE 1 
END AS grp_flag
FROM table_ddl.logins),
grp AS (
    SELECT
        user_id,
        login_date,
        SUM(grp_flag) OVER (
            PARTITION BY user_id
            ORDER BY login_date
        ) AS grp
    FROM t
)

SELECT user_id
FROM grp
GROUP BY user_id, grp
HAVING COUNT(*) >= 3;


-- we are finding breaks in the data (gaps) and islands will itself be identified
WITH gaps AS (
SELECT
*,
LAG(login_date) OVER(PARTITION BY user_id ORDER BY login_date),
CASE 
	WHEN login_date = LAG(login_date) OVER(PARTITION BY user_id 
					ORDER BY login_date) + INTERVAL '1 day'
	THEN 0 
	ELSE 1
END AS gaps
FROM table_ddl.logins),

-- now need to find streaks- running sum to group data
islands AS (
SELECT
*,
SUM(gaps) OVER(PARTITION BY user_id ORDER BY login_date) AS islands
FROM 
gaps)

-- group by user_id and islands
SELECT 
user_id
FROM islands
GROUP BY user_id, islands
HAVING COUNT(islands) >=3

