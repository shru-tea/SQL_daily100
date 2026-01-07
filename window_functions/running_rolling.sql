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

--highest salary in each department along with employee details
SELECT emp_id,
       dept_id,
       salary,
       MAX(salary) OVER (PARTITION BY dept_id) AS highest_salary_in_dept
FROM employees;

-- total no of orders per customer up to that order date

SELECT order_id,
       customer_id,
       order_date,
       COUNT(*) OVER (PARTITION BY customer_id ORDER BY order_date) AS running_total_orders
FROM orders;

--average sale amount per product of all time

SELECT sale_id,
       product_id,
       AVG(amount) OVER (PARTITION BY product_id) AS avg_sale
FROM sales;

-- total transaction amount per user so far 
SELECT txn_id,
       user_id,
       txn_date,
       SUM(amount) OVER (
         PARTITION BY user_id
         ORDER BY txn_date
         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS total_transaction
FROM transactions;

/*
Table: website_visits(user_id, visit_date)

For each visit, show:

user_id

visit_date

number of visits made by that user in the last 3 visits (including current)
*/

SELECT user_id, visit_date,
COUNT(*) OVER(
  PARTITION BY user_id
  ORDER BY visit_date
  ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) AS last_3_visits
FROM website_visits;


/*
Table: orders(order_id, category, order_date, amount)

For each order, display:

order_id

category

sum of order amounts in the last 7 days (including current day) for that category
*/

SELECT order_id, category,
SUM(amount) OVER(
  PARTITION BY category
  ORDER BY order_date
  RANGE BETWEEN INTERVAL '6 days' PRECEDING AND CURRENT ROW
) AS rolling_7_day_sum
FROM orders;


/*
Table: employees(emp_id, dept_id, salary, join_date)

For each employee, show:

emp_id

dept_id

average salary of employees in the same department who joined before or on the same day
*/

SELECT emp_id, dept_id, salary, join_date,
AVG(salary) OVER(
  PARTITION BY dept_id
  ORDER BY join_date
  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS avg_salary_same_dept_before_join_date  
FROM employees;


/*
Table: logins(user_id, login_time)

For each login, show:

user_id

login_time

earliest login time of that user up to that moment
*/

SELECT user_id, login_time,
MIN(login_time) OVER(
  PARTITION BY user_id
  ORDER BY login_time
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS min_time
FROM logins;



/*
Table: transactions(txn_id, account_id, txn_date, amount)

For each transaction, compute:

txn_id

account_id

sum of transaction amounts in the previous 2 transactions and the current transaction
*/

SELECT txn_id, account_id,
SUM(amount) OVER(
    PARTITION BY account_id
  ORDER BY txn_date
  ROWS BETWEEN 2 PRECEEDING AND CURRENT ROW
) AS sum_txn
FROM transactions;


/*
Table: orders(order_id, customer_id, order_date, amount)

For each order, display:

order_id

customer_id

the maximum order amount the customer has ever placed
*/

SELECT order_id, customer_id,
MAX(amount) OVER(PARTITION BY customer_id) AS max_order
FROM orders;

/*
Table: sensor_readings(sensor_id, reading_time, reading_value)

For each reading, show:

sensor_id

reading_time

average reading value over the last 5 minutes
*/

SELECT
  sensor_id,
  reading_time,
  AVG(reading_value) OVER (
    PARTITION BY sensor_id
    ORDER BY reading_time
    RANGE BETWEEN INTERVAL '5 minutes' PRECEDING AND CURRENT ROW
  ) AS avg_reading
FROM sensor_readings;
