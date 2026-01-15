/*
During the data load - userId and firstName were inserted in the correct order but
the LastName values were inserted in reverse order 
Your task is to correct the data in database so that each user gets the correct LastName
*/


WITH positional AS (
	SELECT *,
	ROW_NUMBER() OVER(ORDER BY userId) as positional_rank
	FROM table_ddl.Userdata
) ,

correct_pos AS (
	SELECT *,
	ROW_NUMBER() OVER(ORDER BY userId DESC) as correct_rank
	FROM table_ddl.Userdata
)

SELECT 
p.userId, p.firstName, c.lastName
FROM positional p 
JOIN correct_pos c
ON p.positional_rank = c.correct_rank
 

