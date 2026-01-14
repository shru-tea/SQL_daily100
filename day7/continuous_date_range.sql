/* Identify continuous date ranges and return start_date and end_date.*/

SELECT min(event_date) as start_date, max(event_date) as end_date
FROM (
  SELECT event_date,
         ROW_NUMBER() OVER(ORDER BY event_date),
         event_date - ROW_NUMBER() OVER(ORDER BY event_date) as diff
  FROM events
) t
GROUP BY diff;