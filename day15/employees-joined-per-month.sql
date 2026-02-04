SELECT
TO_CHAR(join_date,'month'),
COUNT(emp_name) AS employee_joined_per_month
FROM table_ddl.employee
GROUP BY 1
ORDER BY 1