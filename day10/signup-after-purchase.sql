--rno for making sure it is first and second event
SELECT
user_id
FROM
(
SELECT
*,
ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY event_date) AS rno
FROM table_ddl.events)
GROUP BY user_id
HAVING
MAX(CASE WHEN rno=1 THEN event_type END) = 'signup'
AND MAX(CASE WHEN rno=2 THEN event_type END) = 'purchase'


-- lead when it can be signup after purchase in any txn
SELECT
user_id
FROM
(
SELECT
*,
LEAD(event_type) OVER(PARTITION BY user_id ORDER BY event_date) as next_event,
CASE 
	WHEN event_type = 'signup' AND LEAD(event_type) OVER(PARTITION BY user_id ORDER BY event_date) = 'purchase'
	THEN 'Y'
	ELSE 'N'
END AS valid_user
FROM table_ddl.events)
WHERE valid_user = 'Y'

SELECT
user_id 
FROM (
    SELECT *,
    LEAD(event_type) OVER (PARTITION BY user_id ORDER BY event_date) AS next_event
    FROM table_ddl.events
)
WHERE event_type='signup' AND next_event='purchase';