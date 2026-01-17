-- Manager with most direct employees
SELECT
e2.emp_name AS manager_name,
COUNT(e1.emp_id) AS total_reportees
FROM table_ddl.manager_employees e1
JOIN table_ddl.manager_employees e2
ON e1.manager_id = e2.emp_id
GROUP BY e2.emp_name
ORDER BY COUNT(e1.emp_id) DESC