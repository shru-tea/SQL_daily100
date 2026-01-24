/*Return employees who joined in the same year as at least one other employee.*/

SELECT emp_id, emp_name
FROM employees 
WHERE EXTRACT(YEAR FROM join_date) IN (
    SELECT EXTRACT(YEAR FROM join_date)
    FROM employees 
    GROUP BY EXTRACT(YEAR FROM join_date)
    HAVING COUNT(*)>1
)