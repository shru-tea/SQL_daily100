/*Return users who logged in for at least 3 consecutive days.*/

SELECT user_id
FROM (
  SELECT user_id,
         login_date,
         ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY login_date) AS rnk,
         login_date - (ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY login_date) || ' days')::interval AS diff
  FROM logins
) t
GROUP BY user_id, diff
HAVING COUNT(*) >= 3;
