/*
Assume you have an events table on Facebook app analytics. Write a query to calculate the click-through rate (CTR) for the app in 2022 and round the results to 2 decimal places.
*/

SELECT 
app_id,
ROUND(100.0 * SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END) / 
SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END),2) AS ctr
FROM events
WHERE date_part('year',timestamp) = 2022
GROUP BY app_id
;