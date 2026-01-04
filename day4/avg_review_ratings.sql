/*
Given the reviews table, write a query to retrieve the average star 
rating for each product, grouped by month. The output should display 
the month as a numerical value, product ID, and average star rating 
rounded to two decimal places. Sort the output first by month and then by product ID.
*/

SELECT EXTRACT(MONTH FROM r.review_date) AS review_month,
       r.product_id,
       ROUND(AVG(r.star_rating), 2) AS avg_star_rating
FROM reviews r
GROUP BY review_month, r.product_id
ORDER BY review_month, r.product_id;