/*
As a HR Analyst, you're asked to identify all employees who earn more than their direct managers. The result should include the employee's ID and name.
*/

SELECT e1.employee_id, e1.name 
FROM employee e1 
JOIN employee e2
ON e1.manager_id = e2.employee_id
WHERE e1.salary > e2.salary;