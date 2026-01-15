/*
Input Tables
parents
parent_id	parent_name
1	John
2	Mary

children
child_id	child_name	parent_id
1	A	2
2	B	1

📌 parent_id assigned based on wrong row position

Expected Output
child_id	child_name	corrected_parent_id
1	A	1
2	B	2
*/

SELECT
    c.child_id,
    c.child_name,
    p.parent_id AS corrected_parent_id
FROM (
    SELECT
        child_id,
        child_name,
        ROW_NUMBER() OVER (ORDER BY child_id) AS rn
    FROM children
) c
JOIN (
    SELECT
        parent_id,
        ROW_NUMBER() OVER (ORDER BY parent_id) AS rn
    FROM parents
) p
ON c.rn = p.rn;
