-- you need to calculate the average rating for each restaurent each month

-- Note : include restaurants that have received at least 2 reviews in a given month

SELECT
month,
restaurant_id,
avg_rating
FROM 
(
SELECT
*,
EXTRACT(MONTH FROM submit_date) as month,
ROUND(AVG(rating) OVER(PARTITION BY restaurant_id,EXTRACT(MONTH FROM submit_date)),2) as avg_rating
FROM table_ddl.reviews)
GROUP BY month, restaurant_id,avg_rating
HAVING COUNT(rating) >=2

SELECT 
EXTRACT(MONTH FROM submit_date) AS month,
restaurant_id,
ROUND(AVG(rating),2) AS avg_rating
FROM reviews 
GROUP BY restaurant_id, EXTRACT(MONTH FROM submit_date)
HAVING COUNT(rating) >= 2;

--each combination of restaurant each month