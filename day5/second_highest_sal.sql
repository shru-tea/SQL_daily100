/*
Imagine you're an HR analyst at a tech company tasked with analyzing employee salaries. Your manager is keen on understanding the pay distribution and asks you to determine the second highest salary among all employees.

It's possible that multiple employees may share the same second highest salary. In case of duplicate, display the salary only once.

Write an SQL query to find the second highest salary from the Employee table.
*/

SELECT DISTINCT Salary AS SecondHighestSalary
FROM (
    SELECT 
        Salary,
        DENSE_RANK() OVER(ORDER BY Salary DESC) AS rnk
    FROM Employee
) t
WHERE rnk = 2;

-- originally used the ROW_NUMBER() formula as well. However, when there are 2 employees have highest salary
-- I had a similar thought at first, but realized that row_number() can only be used if 
--you're assuming that the highest salary is only earned by one employee.
-- If multiple employees each earn the highest salary, then using row_number() would still return that highest salary. 
--The overall approach would require use of dense_rank() instead of row_number()