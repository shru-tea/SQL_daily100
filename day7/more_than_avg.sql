/* Return employees who earn more than the average salary in their department */

SELECT 
emp_id 
FROM 
(SELECT 
emp_id, 
dept, 
salary, 
AVG(salary) OVER(PARTITION BY dept) AS avg_salary_in_dept
FROM employees
) t 
WHERE salary > avg_salary_in_dept;


