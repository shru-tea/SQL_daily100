/*
Table: employees(emp_id, dept_id, salary)

Task:
Assign a row number to each employee within their department, ordered by salary descending.
*/

SELECT emp_id,
       dept_id,
       salary,
       ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS row_num
FROM employees;

-- Highest salary per department with employee details

SELECT emp_id,
       dept_id,
       salary,
       MAX(salary) OVER (PARTITION BY dept_id) AS max_sal
FROM employees;


--Deduplicate records 
SELECT *
FROM (
  SELECT user_id,
         email,
         updated_at,
         ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY updated_at DESC) AS rnk
  FROM users
) t
WHERE rnk = 1;

-- Count rows per group 
SELECT order_id,
       customer_id,
       COUNT(order_id) OVER (PARTITION BY customer_id) AS total_orders_placed
FROM orders;


--Rank salaries within each department with no gaps 
SELECT emp_id,
       dept_id,
       salary,
       DENSE_RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS rnk
FROM employees;


--Previous sale amount for the same product 

SELECT sale_id,
 product_id, amount,
 LAG(amount) OVER(PARTITION BY product_id ORDER BY sale_date) AS prev_sale_amount
FROM sales;

--Running total of sales per customer
SELECT txn_id,
       user_id,
       txn_date,
       amount,
       SUM(amount) OVER (PARTITION BY user_id ORDER BY txn_date) AS running_total
FROM transactions;

-- percent contribution (medium) 

SELECT order_id, category, amount, 
ROUND(amount / SUM(amount) OVER(PARTITION BY category) * 100, 2) 
AS percentage_contribution
FROM orders;


--Identiy duplicates  ( flagging )

SELECT
  customer_id,
  email,
  created_at,
  CASE
    WHEN ROW_NUMBER() OVER (
           PARTITION BY email
           ORDER BY created_at
         ) = 1
    THEN 'N'
    ELSE 'Y'
  END AS is_duplicate
FROM customers;


