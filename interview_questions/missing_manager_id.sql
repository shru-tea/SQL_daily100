/*
Question 4: Missing Manager IDs (SELECT-only fix)
Input Table: employees
emp_id	emp_name	manager_name	manager_id
1	Alice	NULL	NULL
2	Bob	Alice	NULL
3	Carol	Alice	NULL
4	David	Bob	NULL

📌 manager_name is correct, manager_id is missing

Expected Output
emp_id	emp_name	manager_name	corrected_manager_id
1	Alice	NULL	NULL
2	Bob	Alice	1
3	Carol	Alice	1
4	David	Bob	2

*/

SELECT e1.emp_id, 
e1.emp_name,
e1.manager_name,
e2.emp_id AS corrected_manager_id 
FROM employees e1 
LEFT JOIN employees e2 
ON e1.manager_name = e2.emp_name;