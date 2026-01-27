-- Find users who viewed at least 3 distinct pages within any rolling 10-minute window.

SELECT
 DISTINCT pv1.user_id
FROM table_ddl.page_views pv1
JOIN table_ddl.page_views pv2
ON pv1.user_id= pv2.user_id
WHERE pv2.view_time BETWEEN pv1.view_time AND 
							pv1.view_time + INTERVAL '10 mins'
GROUP BY pv1.user_id, pv1.view_time
HAVING COUNT(DISTINCT pv2.page) >=3