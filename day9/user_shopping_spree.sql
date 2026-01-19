/*
Amazon asked for your help to obtain data about users who go on shopping sprees. A shopping spree occurs when a user makes purchases on 3 or more consecutive days.

List the user IDs who have gone on at least 1 shopping spree in ascending order.
*/

SELECT
user_id
FROM
(SELECT 
* ,
transaction_date::DATE as tdate,
ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date) AS rno,
EXTRACT(DAY FROM transaction_date) - ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date) 
AS diff
FROM transactions) t
GROUP BY user_id
HAVING COUNT(*) >=3
ORDER BY 1;

SELECT
user_id
FROM
(SELECT
*,
LEAD(transaction_date,1) OVER(PARTITION BY user_id ORDER BY transaction_date) as first_day,
LEAD(transaction_date,2) OVER(PARTITION BY user_id ORDER BY transaction_date) as second_day
FROM 
transactions) t 
WHERE first_day=transaction_date + INTERVAL '1 day'
AND second_day = transaction_date + INTERVAL '2 days'
ORDER BY user_id