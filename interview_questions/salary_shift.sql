/*
During a payroll load, employee salaries were inserted shifted down by one row (last salary moved to first).
Fix the table so every employee gets their correct salary.
*/

SELECT emp_id,emp_name,
       COALESCE(correct_sal,last_correct_sal) AS corrected_salary
FROM (
    SELECT *,
           LEAD(salary) OVER(ORDER BY emp_id) AS correct_sal,
           FIRST_VALUE(salary) OVER(ORDER BY emp_id) AS last_correct_sal
    FROM table_ddl.employee_salary
) t ;
