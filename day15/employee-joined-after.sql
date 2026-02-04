-- Select all employees who joined after 2020-01-01.

SELECT
emp_name
FROM table_ddl.employee
WHERE join_date > '2020-01-01'