/*
A system bug caused every alternate product price to be swapped with the next product.

Input Table: products
product_id	product_name	price
1	Pen	20
2	Pencil	50
3	Eraser	10
4	Sharpener	40
5	Marker	60

📌 Prices of every alternate row are swapped with the next row
📌 Task:
Correct the prices.

Expected Output
product_id	product_name	corrected_price
1	Pen	50
2	Pencil	20
3	Eraser	40
4	Sharpener	10
5	Marker	60
*/

SELECT 
product_id,
product_name,
CASE 
    WHEN rnk % 2 = 1 AND next_price IS NOT NULL THEN next_price
    WHEN rnk % 2 = 0 THEN prev_price
    ELSE price
END AS corrected_price
FROM
(SELECT *,
ROW_NUMBER() OVER(ORDER BY product_id) AS rnk,
LEAD(price) OVER(ORDER BY product_id) AS next_price,
LAG(price) OVER(ORDER BY product_id) AS prev_price
FROM products ) t;