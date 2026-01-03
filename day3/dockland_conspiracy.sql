--setting 
/* 
The rain hasn't stopped for three days. 
The docks are silent, save for the picket line. 
Frank O'Connor knew something. 
He found a discrepancy between the shipping manifests and the automated port systems. 
Someone brought something in during the 'System Maintenance' window last night. 
Find the ship, find the container, and you'll find who killed Frank.
*/

/*
Identify the Ghost Ship
We know a ship slipped in during the maintenance blackout. 
Cross-reference the `radar_logs` against the official `shipping_manifests` 
to identify the ghost vessel that doesn't exist on paper.*/

SELECT r.ship_name, r.status
FROM radar_logs r
lEFT JOIN shipping_manifests s
ON r.ship_name = s.ship_name
WHERE r.status = 'Maintenance' AND s.ship_name IS NULL;

/*ship_name
Port Maintenance 1

log_id	ship_name	timestamp	coordinates	status
r-maintenance	Port Maintenance 1	2023-11-12 02:15:00	40.7132° N, 74.0068° W	Maintenance


SELECT r.ship_name, r.status
FROM radar_logs r
lEFT JOIN shipping_manifests s
ON r.ship_name = s.ship_name
WHERE r.status = 'Maintenance' AND s.ship_name IS NULL;
*/

/*
Locate the Contraband
The ship didn't dock for the view. 
Track the `crane_operations` for any container 
offloaded from that vessel around its arrival time.
 Watch for weight anomalies. 
 
 The ghost ship had to offload somewhere.
  Check the crane logs for activity where the weight matches a standard empty container (tare weight of ~2200kg).

op_id	crane_id	container_id	timestamp	weight_kg	operator_id
op-8f2a-4	Crane #4	MSKU-998212-X	2023-11-12 03:15:00	2200	u-8821
*/

SELECT *
FROM crane_operations
WHERE timestamp >= '2023-11-12 02:15:00'
  AND timestamp < '2023-11-12 05:15:00';

/* Calculate Laundered Total
They needed to pay for this operation. 
Flag all `bank_transactions` to the offshore shell company
 that utilize "structuring" (transfers just below $10,000)
  to bypass alerts. Sum the total. */

SELECT sender_account, receiver_account, SUM(amount) as total from bank_transactions 
where amount>9000 AND amount<=10000
group by 1,2
ORDER BY total DESC;

/* sender_account	receiver_account	total
Union Fund	ACC-Cayman-77	47500*/

/* Unmask the Insider
Money leaves a trail. 
Match the offshore account number from the transactions to
our `union_members` registry to identify the corrupt official. */

SELECT b.sender_account,b.receiver_account,u.full_name from bank_transactions b 
LEFT JOIN union_members u
ON b.receiver_account = u.account_number
WHERE u.account_number IS NOT NULL AND u.account_number = 'ACC-Cayman-77'
GROUP BY 1,2,3

/*sender_account	receiver_account	full_name
Union Fund	ACC-Cayman-77	Marcus Thorne*/
