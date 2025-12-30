--Write a query that returns the user ID of all users that have created at least one ‘Refinance’ submission and at least one ‘InSchool’ submission.

SELECT user_id 
FROM loans 
GROUP BY user_id 
HAVING 
SUM(CASE WHEN type='Refinance' THEN 1 ELSE 0 END) >= 1 
AND SUM(CASE WHEN type='InSchool' THEN 1 ELSE 0 END) >= 1; 