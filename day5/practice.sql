/*
Table: orders(order_id, customer_id, order_date, amount)

Find the top 3 customers by total spending in 2023.
Return:

customer_id

total_spent
*/

SELECT 
customer_id, 
SUM(amount) AS total_spent
FROM orders 
WHERE order_date >= '2023-01-01' 
  AND order_date < '2024-01-01'
GROUP BY customer_id
ORDER BY total_spent DESC;

/*
Table: orders(order_id, customer_id, order_date, amount)

For each order, show:

order_id

customer_id

the customer’s total lifetime spend

the percentage contribution of this order to that customer’s total spend
*/

SELECT 
order_id,
customer_id,
SUM(amount) OVER(PARTITION BY customer_id) AS total_lifetime_spend,
ROUND((amount * 100.0) / SUM(amount) OVER(PARTITION BY customer_id), 2) AS percentage_contribution
FROM orders;

/*
Table: employees(emp_id, dept_id, salary)

Find the average salary per department, but also return each employee row with that average.
*/

SELECT
emp_id, dept_id, salary,
AVG(salary) OVER(PARTITION BY dept_id) AS avg_salary_per_dept
FROM employees;


/*
Table: transactions(txn_id, user_id, txn_date, amount)

For each transaction, determine whether it is the largest transaction so far for that user.

Return:

txn_id

user_id

is_largest_so_far (Y / N)
*/

SELECT 
txn_id, user_id,
MAX(amount) OVER(PARTITION BY user_id ORDER BY txn_date) AS largest_so_far,
CASE WHEN amount = MAX(amount) OVER(PARTITION BY user_id ORDER BY txn_date) THEN 'Y' ELSE 'N' END AS is_largest_so_far
FROM transactions;

/*
5️⃣

Table: logins(user_id, login_time)

Find users who logged in on at least 3 consecutive days. */

WITH log_date AS (
    SELECT 
    user_id,
    DATE(login_time) AS login_date,
    DENSE_RANK() OVER(PARTITION BY user_id ORDER BY DATE(login_time)) AS rnk,
    DATE(login_time) - DENSE_RANK() OVER(PARTITION BY user_id ORDER BY DATE(login_time)) AS date_diff
    FROM logins
) 

SELECT user_id
FROM log_date
GROUP BY user_id, date_diff
HAVING COUNT(*) >= 3;

/*
6️⃣

Table: sales(order_id, product_id, sale_date, amount)

For each product, find the day with the highest sales amount, and return:

product_id

sale_date

daily_sales_amount
*/
--sales → daily totals → pick max day

WITH daily_sales AS (
    SELECT 
    product_id,
    sale_date,
    SUM(amount) AS daily_sales_amount
    FROM sales
    GROUP BY product_id, sale_date
)
SELECT 
product_id,
sale_date,
daily_sales_amount
FROM (
    SELECT 
    *,
    RANK() OVER(PARTITION BY product_id ORDER BY daily_sales_amount DESC) AS rnk
    FROM daily_sales
) t
WHERE rnk = 1;



/*
7️⃣

Table: orders(order_id, customer_id, order_date, amount)

For each order, show:

order_id

customer_id

number of orders the customer placed in the previous 30 days (excluding today)
*/

SELECT 
order_id,
customer_id,
COUNT(*) OVER(
    PARTITION BY customer_id 
    ORDER BY order_date 
    RANGE BETWEEN INTERVAL '30' DAY PRECEDING AND INTERVAL '1' DAY PRECEDING
) AS orders_in_prev_30_days 
FROM orders;

/*
8️⃣

Table: employees(emp_id, dept_id, salary, join_date)

Find the median salary per department.

9️⃣

Table: queries(query_id, employee_id, query_starttime)

For each employee, show:

employee_id

number of queries run in Q3 2023

how that number ranks among all employees

🔟

Table: transactions(txn_id, account_id, txn_date, amount)

Find accounts whose average transaction amount increased month-over-month for at least 3 consecutive months.

1️⃣1️⃣

Table: orders(order_id, category, order_date, amount)

For each category, show:

total revenue

the first order date

the last order date

1️⃣2️⃣

Table: employees(emp_id, manager_id, salary)

For each employee, show:

their salary

their manager’s salary

the difference between the two

(Assume manager_id references emp_id)

1️⃣3️⃣

Table: page_views(user_id, view_time)

Find users who viewed the site more than 5 times in any rolling 10-minute window.

1️⃣4️⃣

Table: orders(order_id, customer_id, order_date, amount)

Create a spending bucket for each customer:

Low (< 1000 total spend)

Medium (1000–5000)

High (> 5000)

Return:

customer_id

spending_bucket

1️⃣5️⃣

Table: transactions(txn_id, user_id, txn_date, amount)

For each transaction, show:

txn_id

user_id

running average transaction amount

rolling 7-day average transaction amount

*/