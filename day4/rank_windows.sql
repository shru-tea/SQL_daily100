--Rank customers based on their total spending

SELECT customer_id,
       SUM(amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(amount) DESC) AS spending_rank
FROM purchases
GROUP BY customer_id;