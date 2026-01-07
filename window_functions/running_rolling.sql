SELECT 
orderId,
productId,
orderDate,
Sales,
AVG(Sales) OVER(PARTITION BY productId) AS avg_sales_per_product,
AVG(Sales) OVER(PARTITION BY productId ORDER BY orderDate) AS running_avg_sales_per_product,
AVG(Sales) OVER(PARTITION BY productId ORDER BY orderDate 
ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS rolling_avg_next_2_orders_per_product
FROM Sales.Orders;