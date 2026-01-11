--Write a query to find how many UHG policy holders made three, or more calls, assuming each call is identified by the case_id column.

SELECT COUNT(policy_holder_id) AS policy_holders_with_3_or_more_calls
FROM (
SELECT 
    policy_holder_id,
    COUNT(case_id) AS total_calls
FROM callers
GROUP BY policy_holder_id
HAVING COUNT(case_id) >= 3   -- this will give all the policy holders with 3 or more calls, we need to find the count of these
) t ;

