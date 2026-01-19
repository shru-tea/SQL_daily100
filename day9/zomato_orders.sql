--  Imagine each order's item has been mistakenly swapped with the
--next—our task is to use Common Table Expressions (CTEs) to realign the order IDs with the correct items. Follow along as we solve this problem step-by-step and ensure data integrity.

-- STEP 1 : Since order was swapped in pairs, need to find
-- odd/even row number (ROW_NUMBER)

-- STEP 2: Since it is pairwise swapping, we need both LEAD and LAG

SELECT 
order_id,
item AS previous_item,
CASE 
	WHEN row_no % 2 = 0 THEN prev_item
	WHEN row_no % 2 = 1 AND next_item IS NOT NULL THEN next_item
	ELSE item
END AS corrected_item
FROM
(SELECT 
*,
ROW_NUMBER() OVER(ORDER BY order_id) AS row_no,
LEAD(item) OVER(ORDER BY order_id) AS next_item,
LAG(item) OVER(ORDER BY order_id) AS prev_item
FROM table_ddl.orders_zomato) t