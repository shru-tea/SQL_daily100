/*
Write a solution to find all customers who never order anything.

Return the result table in any order.
*/

-- Write your PostgreSQL query statement below
SELECT c.name as Customers
FROM Customers c
LEFT JOIN Orders o 
ON c.id = o.customerId
WHERE o.id IS NULL;