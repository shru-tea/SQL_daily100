/*
user_activity
-------------
activity_id
user_id
activity_type
device_type
activity_date

Find pairs of users who performed the same activity type on the same device multiple times.

| activity_id | user_id | activity_type | device_type | activity_date |
| ----------- | ------- | ------------- | ----------- | ------------- |
| 1           | 201     | Login         | Mobile      | 2023-03-01    |
| 2           | 201     | Purchase      | Mobile      | 2023-03-02    |
| 3           | 201     | Login         | Desktop     | 2023-03-03    |
| 4           | 202     | Login         | Mobile      | 2023-03-01    |
| 5           | 202     | Login         | Mobile      | 2023-03-04    |
| 6           | 202     | Purchase      | Mobile      | 2023-03-05    |
| 7           | 203     | Login         | Desktop     | 2023-03-02    |
| 8           | 203     | Purchase      | Desktop     | 2023-03-06    |

same activity type and device type PER user pair. --> group by USER PAIR

*/

SELECT u1.user_id AS user1, u2.user_id AS user2,
COUNT(*) AS shared_activity_count
FROM user_activity u1 JOIN user_activity u2 
ON u1.activity_type = u2.activity_type
AND u1.device_type = u2.device_type 
AND u1.user_id < u2.user_id
GROUP BY 1,2
HAVING COUNT(*) > 1
ORDER BY shared_activity_count DESC;

