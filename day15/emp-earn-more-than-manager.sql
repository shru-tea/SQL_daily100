--Employees earning more than their manager.
SELECT
e1.emp_name
FROM table_ddl.employee e1
JOIN table_ddl.employee e2
ON e1.manager_id=e2.emp_id
WHERE e1.salary>e2.salary