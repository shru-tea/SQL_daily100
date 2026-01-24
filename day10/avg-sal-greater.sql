--SELECT * FROM table_ddl.employee_sal

--find salary greater than the avg salary in a dept
SELECT
e1.emp_id, e1.department, e1.salary
FROM table_ddl.employee_sal e1
WHERE e1.salary > (
SELECT 
--e2.department
ROUND(AVG(e2.salary),2) as avg_salary 
FROM table_ddl.employee_sal e2
WHERE e1.department=e2.department
--GROUP BY e2.department 
)

-- with window functions
SELECT 
emp_id, department, salary
FROM (
SELECT
*,
AVG(salary) OVER(PARTITION BY department) AS avg_salary
FROM table_ddl.employee_sal) t
WHERE salary > ROUND(avg_salary,2)


