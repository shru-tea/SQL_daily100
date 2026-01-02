--find employees who joined before their manager from employee table

select e1.emp_name as employee_name, e2.emp_name as manager_name
from employee e1 JOIN employee e2 
ON e1.manager_id = e2.emp_id 
where e1.join_date < e2.join_date;
