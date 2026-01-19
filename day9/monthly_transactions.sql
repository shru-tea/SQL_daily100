/*
Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount.

Return the result table in any order.
*/

-- Write your PostgreSQL query statement below

SELECT
TO_CHAR(trans_date,'YYYY-MM') as month,
country,
COUNT(state) AS trans_count,
SUM(CASE WHEN state='approved' THEN 1 ELSE 0 END) AS approved_count,
SUM(amount) AS trans_total_amount,
SUM(CASE WHEN state='approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM transactions
GROUP BY TO_CHAR(trans_date,'YYYY-MM'), country
