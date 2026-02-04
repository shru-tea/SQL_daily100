--List all employees along with their department names.

SELECT
e.emp_name,d.dept_name
FROM table_ddl.employee e
INNER JOIN table_ddl.departments d
ON e.dept_id=d.dept_id
