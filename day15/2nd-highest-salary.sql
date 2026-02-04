--Second highest salary per department
SELECT
emp_name,salary,dept_id
FROM(
SELECT
*,
DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rnk
FROM table_ddl.employee) t
WHERE rnk =2