-- for deduplication - always use ROW_NUMBER() to get the latest record per user

SELECT user_id, status, updated_at
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY user_id
               ORDER BY updated_at DESC
           ) AS rno
    FROM table_ddl.user_logs
) t
WHERE rno = 1;