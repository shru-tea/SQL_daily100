--Employees whose salary is above department average.

SELECT
*
FROM table_ddl.employee e1
WHERE salary > (
SELECT AVG(salary) FROM table_ddl.employee e2 WHERE e1.dept_id = e2.dept_id
)


SELECT
emp_name
FROM
(
SELECT
*,
ROUND(AVG(salary) OVER(PARTITION BY dept_id),2) AS avg_salary
FROM table_ddl.employee) t
WHERE salary > avg_salary