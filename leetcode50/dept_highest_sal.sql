/*
Write a solution to find employees who have the highest salary in each of the departments.

Return the result table in any order.
*/

-- Write your PostgreSQL query statement below
With employee_cte AS (
SELECT
*,
DENSE_RANK() OVER(PARTITION BY departmentId ORDER BY salary DESC) as rnk
FROM Employee)

SELECT d.name AS Department, e.name AS Employee, e.salary AS Salary
FROM 
employee_cte e 
JOIN Department d
ON e.departmentId = d.id
WHERE rnk = 1


SELECT 
d.name AS Department,
e.name AS Employee,
e.salary AS Salary
FROM Employee e
JOIN Department d
ON e.departmentId = d.id
WHERE e.salary = (
    SELECT MAX(salary) FROM Employee WHERE departmentId = d.id
)