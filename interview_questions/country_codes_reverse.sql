/*
Input Table: customers
customer_id	country	country_code
1	India	+44
2	UK	+91
3	USA	+49
4	Germany	+1

📌 Country codes inserted in reverse regional order

Expected Output
customer_id	country	corrected_country_code
1	India	+91
2	UK	+44
3	USA	+1
4	Germany	+49
*/

SELECT customer_id, country,
CASE
    WHEN rnk % 2 = 1 AND next_code IS NOT NULL THEN next_code
    WHEN rnk % 2 = 0 THEN prev_code
    ELSE country_code
END AS corrected_country_code 
FROM (
    SELECT *, 
           ROW_NUMBER() OVER (ORDER BY customer_id) AS rnk,
           LEAD(country_code) OVER (ORDER BY customer_id) AS next_code,
           LAG(country_code) OVER (ORDER BY customer_id) AS prev_code
    FROM customers
) t;