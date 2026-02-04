SELECT
e1.emp_name AS employee,e2.emp_name AS manager_name
FROM table_ddl.employee e1
JOIN table_ddl.employee e2
ON e1.manager_id = e2.emp_id