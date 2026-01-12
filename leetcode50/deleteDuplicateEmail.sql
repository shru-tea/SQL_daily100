/*
Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.

For SQL users, please note that you are supposed to write a DELETE statement and not a SELECT one.
*/

--using WF

WITH ranked AS (
    SELECT id
    FROM (
        SELECT id,
               ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) AS rnk
        FROM Person
    ) t
    WHERE rnk > 1
)

DELETE FROM Person WHERE id IN (SELECT id FROM ranked);

--without WF

DELETE FROM Person
WHERE id NOT IN (select MIN(id) FROM Person GROUP BY email)

DELETE p1 FROM Person p1
JOIN Person p2 
ON p1.email = p2.email AND p1.id > p2.id;