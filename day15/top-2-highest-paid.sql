--Top 2 highest-paid employees per department.

SELECT
emp_name,salary
FROM(
SELECT
*,
DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rnk
FROM table_ddl.employee) t
WHERE rnk <=2

--Top 2 highest-paid employees per department.
--USE ROW_NUMBER() to get unique rows only
/*
This returns exactly 2 employees per department, even if salaries are tied.

⚠️ Important nuance (interview favorite)

If two employees tie for the same salary, ROW_NUMBER() will arbitrarily pick one.
*/
SELECT
emp_name,salary
FROM(
SELECT
*,
ROW_NUMBER() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rnk
FROM table_ddl.employee) t
WHERE rnk <=2