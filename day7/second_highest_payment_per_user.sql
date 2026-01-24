/*Return the second highest payment amount per user.*/

SELECT user_id, amount
FROM (
  SELECT *,
         DENSE_RANK() OVER(PARTITION BY user_id ORDER BY amount DESC) AS rnk
  FROM payments
) t
WHERE rnk = 2;
