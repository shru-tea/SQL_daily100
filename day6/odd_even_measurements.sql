/*
Assume you're given a table with measurement values obtained from a Google sensor over multiple days with measurements taken multiple times within each day.

Write a query to calculate the sum of odd-numbered and even-numbered measurements 
separately for a particular day and display the results in two different columns. 
Refer to the Example Output below for the desired format.

Definition:

Within a day, measurements taken at 1st, 3rd, and 5th times are considered 
odd-numbered measurements, and measurements taken at 2nd, 4th, and 6th times are 
considered even-numbered measurements.
*/

SELECT
measurement_day,
SUM(CASE WHEN rnk % 2 = 1 THEN measurement_value END) AS odd_sum,
SUM(CASE WHEN rnk% 2 = 0 THEN measurement_value END) AS even_sum
FROM(
SELECT
*,
DATE(measurement_time) AS measurement_day,
ROW_NUMBER() OVER(PARTITION BY DATE(measurement_time) ORDER BY measurement_time) as rnk
FROM measurements) t
GROUP BY measurement_day