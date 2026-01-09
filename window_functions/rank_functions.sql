-- find the lowest 2 customers based on their total sales

SELECT * FROM(
SELECT 
CustomerId,
SUM(Sales),
ROW_NUMBER() OVER(ORDER BY SUM(Sales) ASC) AS rnk
FROM Sales.Orders
GROUP BY CustomerId
) t 
WHERE rnk <=2;


-- segment all orders into 3 categories based on sales amount : High, Medium, Low

SELECT *,
CASE WHEN buckets = 1 THEN 'High'
     WHEN buckets = 2 THEN 'Medium'
     ELSE 'Low' END AS sales_category
FROM(
SELECT 
OrderId,
Sales,
NTILE(3) OVER(ORDER BY Sales DESC) AS buckets
FROM Sales.Orders ) t ;


-- in order to export the data, divide it into 2 groups

SELECT *,
NTILE(2) OVER(ORDER BY OrderId) AS export_group
FROM Sales.Orders;


-- Find the products that fall within the highest 40% of prices 
SELECT 
* FROM (
SELECT 
productId,
Price,
CUME_DIST() OVER(ORDER BY Price DESC) AS DistRank
FROM Sales.Products ) t 
WHERE DistRank <=0.4;

-- ananlyze the month-over-month performance by finding the percentage change 
-- in sales between the current month and the previous month

SELECT 
*,
CurrentMonthSales - previousMonthSales AS SalesDifference,
CONCAT(ROUND((CAST(CurrentMonthSales - previousMonthSales) AS FLOAT * 100.0) / previousMonthSales, 2), '%') AS PercentageChange
FROM(
SELECT
MONTH(OrderDate) AS orderMonth,
SUM(Sales) AS CurrentMonthSales,
LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate) DESC) AS previousMonthSales
FROM Orders
GROUP BY MONTH(OrderDate) ) t;