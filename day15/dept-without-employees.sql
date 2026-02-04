--Departments without employees.
SELECT
*
FROM table_ddl.departments d
LEFT JOIN table_ddl.employee e
ON e.dept_id =d.dept_id
WHERE e.dept_id IS NULL