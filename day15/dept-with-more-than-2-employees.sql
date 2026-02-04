--Departments with more than 2 employees.

SELECT
d.dept_name
FROM table_ddl.employee e
JOIN table_ddl.departments d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING COUNT(*) >2