/*
purchases
---------
purchase_id
customer_id
product_category
payment_method
purchase_date

Find pairs of customers who share multiple product categories and payment methods.
multiple product categories and payment methods PER customer pair.

| purchase_id | customer_id | product_category | payment_method | purchase_date |
| ----------- | ----------- | ---------------- | -------------- | ------------- |
| 1           | 101         | Electronics      | Card           | 2023-01-10    |
| 2           | 101         | Electronics      | UPI            | 2023-01-15    |
| 3           | 101         | Clothing         | Card           | 2023-02-01    |
| 4           | 102         | Electronics      | Card           | 2023-01-12    |
| 5           | 102         | Electronics      | Card           | 2023-01-20    |
| 6           | 102         | Clothing         | Card           | 2023-02-05    |
| 7           | 103         | Electronics      | Card           | 2023-01-18    |
| 8           | 103         | Clothing         | UPI            | 2023-02-10    |


*/

SELECT p1.customer_id AS customer1, p2.customer_id AS customer2,
COUNT(*) AS shared_patterns 
FROM purchases p1 JOIN purchases p2
ON p1.product_category = p2.product_category
AND p1.payment_method = p2.payment_method
AND p1.customer_id < p2.customer_id 
GROUP BY 1,2
HAVING COUNT(*) > 1
ORDER BY shared_patterns DESC;



