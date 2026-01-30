SELECT txn_id, user_id, amount, txn_time
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY user_id, amount
               ORDER BY txn_time
           ) AS rnk
    FROM table_ddl.transactions_one
) t
WHERE rnk = 1;

-- txn_time can aslo be ties

SELECT txn_id, user_id, amount, txn_time
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY user_id, amount
               ORDER BY txn_time,txn_id
           ) AS rnk
    FROM table_ddl.transactions_one
) t
WHERE rnk = 1;