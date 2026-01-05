--find the percentage contribution of each product's sales to the total sales

SELECT 
OrderId,
ProductId,
Sales,
SUM(SALES) OVER () AS TotalSales,
ROUND((Sales * 100.0) / SUM(SALES) OVER (), 2) AS PercentageOfTotalSales  --part to whole analysis
FROM Sales.Orders;


SELECT 
OrderId,
OrderDate,
ProductId,
AVG(COALESCE(Sales, 0)) OVER() AS overall_avg_sales,
AVG(COALESCE(Sales, 0)) OVER(PARTITION BY ProductId) AS avg_sales_per_product --group wise average
FROM Sales.Orders;

--Always handle NULLs in window functions to avoid unexpected results
SELECT 
CustomerId,
LastName,
Score,
AVG(Score) OVER(PARTITION BY CustomerId) AS avg_score_per_customer --this will not consider NULL when doing avg (dividing)
AVG(COALESCE(Score, 0)) OVER(PARTITION BY CustomerId) AS avg_score_per_customer
FROM Sales.Customers;

--Find all orders where sales are higher than the average sales for that product and across all orders
--COMPARE TO AVERGAE ANALYSIS

SELECT
* 
FROM ( 
Select 
OrderId,
Sales,
ProductId,
AVG(COALESCE(Sales,0)) OVER() AS overall_avg_sales,
AVG(COALESCE(Sales,0)) OVER(PARTITION BY ProductId) AS avg_sales_per_product
FROM Sales.Orders
) t 
WHERE Sales > overall_avg_sales AND Sales > avg_sales_per_product;


-- Find the highest and lowest sales of all orders 
-- Find the highest and lowest sales of each product
-- Additionaly, provide all details of the orders 

SELECT 
OrderId,
OrderDate,
productId,
Sales,
MAX(COALESCE(Sales,0)) OVER() AS highest_overall_sales,
MAX(COALESCE(Sales,0)) OVER(PARTITION BY productId) AS highest_sale_per_product,
MIN(COALESCE(Sales,0)) OVER() AS lowest_overall_sales,
MIN(COALESCE(Sales,0)) OVER(PARTITION BY productId) AS lowest_sale_per_product
FROM Sales.Orders;

--Show the employees with the highest salary in each department along with department details

SELECT 
* 
FROM (
SELECT 
e.EmployeeID,
e.FirstName,
e.LastName,
d.departmentName,
e.Salary,
MAX(e.Salary) OVER(PARTITION BY e.DepartmentID) AS highest_salary_in_dept
FROM HR.Employees e
JOIN HR.Departments d ON e.DepartmentID = d.DepartmentID;
) t 
WHERE Salary = highest_salary_in_dept;


