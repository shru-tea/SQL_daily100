-- details of employees having the 3rd highest salary in each job category

SELECT 
employee_id,
first_name,
job_category
FROM
(SELECT 
* ,
DENSE_RANK() OVER(PARTITION BY job_category ORDER BY salary DESC) as rnk
FROM 
table_ddl.salary_of_employees) t 
WHERE rnk = 3