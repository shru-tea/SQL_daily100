/*
Input Table: daily_sales
sale_date	total_sales
2024-01-01	100
2024-01-02	200
2024-01-03	150

📌 Stored values are daily, expected is cumulative

Expected Output
sale_date	corrected_total_sales
2024-01-01	100
2024-01-02	300
2024-01-03	450
*/

SELECT sale_date, corrected_total_sales
FROM (
    SELECT *,
           SUM(total_sales) OVER (ORDER BY sale_date) AS corrected_total_sales
    FROM daily_sales
) t;