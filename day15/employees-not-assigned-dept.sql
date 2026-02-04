--Employees not assigned to any department.
SELECT
*
FROM table_ddl.employee e
LEFT JOIN table_ddl.departments d
ON e.dept_id =d.dept_id
WHERE d.dept_id IS NULL