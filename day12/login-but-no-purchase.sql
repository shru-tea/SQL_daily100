-- loggedin on multiple days but never made a purchase on the same day

SELECT
l.*,p.*
FROM table_ddl.logins_details l
LEFT JOIN table_ddl.purchases p
ON l.user_id = p.user_id
WHERE l.login_date <> p.purchase_date
GROUP BY l.user_id

SELECT
l.user_id,COUNT(*)
FROM table_ddl.logins_details l
LEFT JOIN table_ddl.purchases p
ON l.user_id = p.user_id
AND l.login_date = p.purchase_date
WHERE p.user_id IS NULL
GROUP BY l.user_id