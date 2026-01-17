--return all distinct elements that appear 3 times consecutively

SELECT
distinct
element
FROM (
SELECT 
* ,
--ROW_NUMBER() OVER() AS rnk,
LEAD(element) OVER(ORDER BY (SELECT NULL)) as next_element,
LAG(element) OVER(ORDER BY (SELECT NULL)) as prev_element
FROM table_ddl.elements ) t 
WHERE element = next_element
AND prev_element = element;

-- the above will work only if the order of elements is maintained as in the table.
-- and also when we are asked about 3 consecitive elements but will fail for more

-- so alternative and correct approach is below
-- This works because the middle row of any 3-length run satisfies prev = curr = next.
-- Alternatively, for a more general solution, we can group consecutive values using row_number differences.

WITH numbered AS (
    SELECT
        element,
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
    FROM table_ddl.elements
),
grouped AS (
    SELECT
        element,
        rn,
        rn - ROW_NUMBER() OVER (PARTITION BY element ORDER BY rn) AS grp
    FROM numbered
)
SELECT DISTINCT element
FROM grouped
GROUP BY element, grp
HAVING COUNT(*) >= 3;