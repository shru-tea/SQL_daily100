--Write a query to retrieve the top three cities that have the highest number of completed trade orders listed in descending order. Output the city name and the corresponding number of completed trade orders.
select users.city, COUNT(trades.order_id) as total_orders 
from trades 
LEFT JOIN users 
ON trades.user_id=users.user_id 
WHERE trades.status='completed'
GROUP BY users.city 
ORDER BY total_orders DESC 
LIMIT 3; 