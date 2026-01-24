/*Return records where the salary decreased compared to the previous value.*/

SELECT emp_id, salary, effective_date
FROM (
  SELECT *,
         LAG(salary) OVER(PARTITION BY emp_id ORDER BY effective_date) AS prev_sal
  FROM employee_salary
) t
WHERE salary < prev_sal;
