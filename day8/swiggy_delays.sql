-- the count of delayed orders for each delivery partner. 
WITH order_history AS (
SELECT
orderid,
custid,
city,
del_partner,
predicted_time,
deliver_time - order_time AS diff,
ROUND(EXTRACT(EPOCH FROM deliver_time - order_time::INTERVAL) / 60,0) AS total_minutes,
CASE 
	WHEN ROUND(EXTRACT(EPOCH FROM deliver_time - order_time::INTERVAL) / 60,0) > predicted_time
	THEN 1
	ELSE 0 
END AS is_late
FROM
table_ddl.order_details)

SELECT 
del_partner,
SUM(is_late) AS order_count
FROM order_history
GROUP BY del_partner