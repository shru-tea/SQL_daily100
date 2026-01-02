--Write a query to identify the top 2 Power Users who sent the highest number of messages on Microsoft Teams in August 2022. Display the IDs of these 2 users along with the total number of messages they sent. 
--Output the results in descending order based on the count of the messages.


SELECT
  sender_id,
  COUNT(*) as message_count 
FROM messages 
WHERE EXTRACT(YEAR from sent_date) = 2022 AND EXTRACT(MONTH from sent_date) = 08
GROUP BY sender_id
ORDER BY COUNT(*) DESC 
LIMIT 2;


-- WINDOW functions (need to revisit)
WITH RankedMessages AS (
    SELECT sender_id, COUNT(*) AS message_count,
           RANK() OVER (ORDER BY COUNT(*) DESC) AS rank
    FROM messages
    WHERE sent_date BETWEEN '2022-08-01' AND '2022-09-01'
    GROUP BY sender_id
)
SELECT sender_id, message_count
FROM RankedMessages
WHERE rank <= 2;