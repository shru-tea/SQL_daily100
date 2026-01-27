--Find drivers who accepted at least one ride but never completed any ride

SELECT
r.driver_id,
COUNT(*) AS incomplete_rides
FROM table_ddl.rides r
WHERE status = 'accepted'
AND NOT EXISTS (
SELECT 1
FROM table_ddl.rides r1
WHERE r.driver_id = r1.driver_id  
AND r1.status = 'completed'
)
GROUP BY 1