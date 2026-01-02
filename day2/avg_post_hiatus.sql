-- for each user who posted at least twice in 2021, 
--write a query to find the number of days between each user’s first post of the year and last post of the year in the year 2021. Output the user and number of the days between each user's first and last post.

--using CTE 

WITH at_least_twice_posted AS (
    SELECT user_id,
    MIN(post_date) AS first_post_date,
    MAX(post_date) AS last_post_date
    FROM posts
    WHERE EXTRACT(YEAR FROM post_date) = 2021
    GROUP BY user_id
    HAVING COUNT(*) >=2
)

SELECT user_id,
DATE_PART('day',last_post_date - first_post_date) AS days_between 
FROM at_least_twice_posted;

-- without using CTE

SELECT 
user_id,
DATE_PART('day', MAX(post_date) - MIN(post_date)) AS days_between
FROM posts
WHERE EXTRACT(YEAR FROM post_date) = 2021
GROUP BY user_id 
HAVING COUNT(*)>=2 
ORDER BY user_id;


SELECT 
user_id,
EXTRACT(DAY FROM (MAX(post_date) - MIN(post_date))) AS days_between
FROM posts
WHERE EXTRACT(YEAR FROM post_date) = 2021
GROUP BY user_id 
HAVING COUNT(*)>=2 
ORDER BY user_id;