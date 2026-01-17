/*
A 'high earner' within a department is defined as an employee with a salary 
ranking among the top three salaries within that department.
Write a query to display the employee's name along with their department
name and salary. In case of duplicates, sort the results of department name in 
ascending order, then by salary in descending order. If multiple employees 
have the same salary, then order them alphabetically.
*/

WITH cte AS (
SELECT 
e.name, e.salary, e.department_id, d.department_name
FROM employee e 
LEFT JOIN department d 
ON e.department_id = d.department_id
WHERE d.department_id IS NOT NULL )

SELECT department_name, name, salary FROM (
SELECT 
* ,
DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) as rnk
FROM cte 
) t WHERE rnk <=3
ORDER BY department_name ASC, salary DESC, name ASC;