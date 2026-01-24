select
t1.user_id,MAX(t1.amount) as second_highest
FROM table_ddl.transactions_data t1
WHERE t1.amount < (
SELECT MAX(t2.amount) FROM table_ddl.transactions_data t2
WHERE t1.user_id = t2.user_id
)
GROUP BY t1.user_id

WITH ranked_txns AS (
    SELECT
        user_id,
        amount,
        DENSE_RANK() OVER (
            PARTITION BY user_id
            ORDER BY amount DESC
        ) AS dr
    FROM transactions
)
SELECT
    user_id,
    amount AS second_highest_amount
FROM ranked_txns
WHERE dr = 2;