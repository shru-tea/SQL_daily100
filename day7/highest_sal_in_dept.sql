/*Return employees who earn the highest salary in their department.*/

SELECT emp_id, name
FROM (
  SELECT emp_id, name, dept,
         DENSE_RANK() OVER (PARTITION BY dept ORDER BY salary DESC) AS rnk
  FROM employees
) t
WHERE rnk = 1;
