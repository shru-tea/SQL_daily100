--Total salary per department.

SELECT
d.dept_name,
SUM(e.salary) AS total_salary
FROM table_ddl.employee e
JOIN table_ddl.departments d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name