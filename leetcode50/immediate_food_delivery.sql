-- Write your PostgreSQL query statement below

With first_order AS (
SELECT
customer_id, 
MIN(order_date) AS first_order_date
FROM Delivery
GROUP BY customer_id),

status_table AS (
SELECT
CASE
    WHEN f.first_order_date = d.customer_pref_delivery_date THEN
    'Immediate'
    WHEN f.first_order_date < d.customer_pref_delivery_date THEN 
    'Scheduled'
    END AS status
FROM Delivery d 
JOIN first_order f 
ON d.customer_id = f.customer_id
AND d.order_date = f.first_order_date)

SELECT
ROUND(SUM(CASE WHEN status = 'Immediate' THEN 1 ELSE 0 END)*1.0 / COUNT(status) *100,2) AS immediate_percentage
FROM status_table