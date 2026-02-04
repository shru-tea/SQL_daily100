--Employees without a manager.
SELECT
emp_name
FROM table_ddl.employee
WHERE manager_id IS NULL