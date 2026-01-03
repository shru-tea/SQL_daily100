--The inventory shows discrepancies between expected and actual stock. Find items where current stock is significantly less than expected.

SELECT 
po.item_description,
i.expected_stock, i.current_stock,
(i.expected_stock- i.current_stock) as missing
FROM purchase_orders po
LEFT JOIN inventory i 
ON po.po_id = i.po_id
WHERE i.po_id IS NOT NULL AND i.current_stock < i.expected_stock
ORDER BY po.item_description;


SELECT po.item_description, i.expected_stock, i.current_stock, 
(i.expected_stock - i.current_stock) AS missing 
FROM purchase_orders po JOIN inventory i ON po.po_id = i.po_id 
WHERE i.current_stock < i.expected_stock ORDER BY po.item_description;

--warehouse leak :  By correlating the intended destination from the Purchase Order with the missing deliveries, we can find the leak.

SELECT 
po.target_warehouse,
COUNT(*) as missing_shipments 
FROM purchase_orders po 
LEFT JOIN deliveries d 
ON po.po_id = d.po_id
WHERE d.po_id IS NULL
GROUP BY po.target_warehouse
ORDER BY COUNT(*) DESC;

--vendor scorecard :  Summarize each vendor's performance by counting the number of purchase orders placed, the number of successful deliveries made, and the total value of goods ordered from each vendor.

SELECT po.vendor_name, COUNT(po.po_id) AS total_orders, 
COUNT(d.delivery_id) AS successful_deliveries, 
SUM(po.quantity * po.unit_price) AS total_value 
FROM purchase_orders po 
LEFT JOIN deliveries d
ON po.po_id = d.po_id 
GROUP BY po.vendor_name 
ORDER BY successful_deliveries DESC;

SELECT 
po.vendor_name,
COUNT(po.po_id) AS total_orders,
COUNT(d.delivery_id) AS successful_deliveries,
SUM(po.quantity * po.unit_price) AS total_value
FROM purchase_orders po
LEFT JOIN deliveries d 
ON po.po_id = d.po_id
GROUP BY po.vendor_name
ORDER BY successful_deliveries DESC;


--final audit - 
--The DA needs everything. Compile the final audit report listing `po_id`, `vendor_name`, `item_description`, `order_value`, `delivery_status`, and `inventory_loss`. Rank by order value descending.

SELECT 
po.po_id,
po.vendor_name,
po.item_description,
SUM(po.quantity * po.unit_price) AS order_value,
CASE WHEN d.delivery_id IS NULL THEN 'Not delivered' ELSE 'Delivered' END AS delivery_status,
(i.expected_stock - i.current_stock) AS inventory_loss
FROM purchase_orders po
LEFT JOIN deliveries d 
ON po.po_id = d.po_id
LEFT JOIN inventory i 
ON d.po_id = i.po_id
GROUP BY po.po_id, po.vendor_name, po.item_description
ORDER BY order_value DESC

SELECT po.po_id, 
po.vendor_name, 
po.item_description, 
po.quantity * po.unit_price AS order_value, 
CASE WHEN d.delivery_id IS NULL THEN 'Not Delivered' ELSE 'Delivered' END AS delivery_status, 
COALESCE(i.expected_stock - i.current_stock, 0) AS inventory_loss 
FROM purchase_orders po 
LEFT JOIN deliveries d 
ON po.po_id = d.po_id
LEFT JOIN inventory i 
ON po.po_id = i.po_id 
ORDER BY order_value DESC;
