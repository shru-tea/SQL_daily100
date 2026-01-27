--For small partitions, CUME_DIST() produces coarse percentiles
--. In this case, top 1% resolves to only the last row. 
--If the requirement is to always return at least one row, 
--I’d switch to a row-number–based cutoff

-- Find the top 1% highest payments per month.
SELECT
    payment_id,
    payment_date,
    amount
FROM (
    SELECT
        payment_id,
        payment_date,
        amount,
        CUME_DIST() OVER (
            PARTITION BY DATE_TRUNC('month', payment_date)
            ORDER BY amount DESC
        ) AS perc
    FROM table_ddl.payments
) t
WHERE perc >= 0.99;
