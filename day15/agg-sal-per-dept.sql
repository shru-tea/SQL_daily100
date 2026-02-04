--Average, min, max salary per department.

SELECT
d.dept_name,
MIN(e.salary) AS min_salary,
MAX(e.salary) AS max_salary,
ROUND(AVG(e.salary),2) AS avg_salary
FROM table_ddl.employee e
JOIN table_ddl.departments d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name