/*
Assume you're given tables with information about TikTok user sign-ups and confirmations through email and text. New users on TikTok sign up using their email addresses, and upon sign-up, each user receives a text message confirmation to activate their account.

Write a query to display the user IDs of those who did not confirm their sign-up on the first day, but confirmed on the second day.

Definition:

action_date refers to the date when users activated their accounts and confirmed their sign-up through text messages.

*/

SELECT 
e.user_id
FROM emails e 
LEFT JOIN texts t 
ON e.email_id = t.email_id
WHERE t.email_id IS NOT NULL
AND signup_action = 'Confirmed'
AND date_part('day',(t.action_date - e.signup_date)) = 1;

SELECT DISTINCT user_id
FROM (
    SELECT
        e.user_id,
        MAX(CASE WHEN t.signup_action = 'Confirmed' AND date_part('day', t.action_date - e.signup_date) = 0 THEN 1 ELSE 0 END)
            OVER (PARTITION BY e.user_id) AS confirmed_day0,
        MAX(CASE WHEN t.signup_action = 'Confirmed' AND date_part('day', t.action_date - e.signup_date) = 1 THEN 1 ELSE 0 END)
            OVER (PARTITION BY e.user_id) AS confirmed_day1
    FROM emails e
    LEFT JOIN texts t ON e.email_id = t.email_id
) s
WHERE confirmed_day0 = 0
    AND confirmed_day1 = 1;