/*CREATE TABLE table_ddl.hotels (
 hotel_id INT,
 room_number INT,
 available_status VARCHAR(30)
);


INSERT INTO table_ddl.hotels VALUES
(1, 2,'false'),
(1, 3,'true'),
(1, 4,'true'),
(1, 5,'true'),
(2, 101,'true'),
(3, 1001,'true'),
(3, 1001,'true');*/

/*Return the hotel IDs that have at least two consecutive available rooms.*/

-- using window function

-- if explicitly mentioned that room numbers are consecutive/incremental
 SELECT hotel_id, room_number
 FROM
(SELECT 
*,
LEAD(room_number) OVER(PARTITION BY hotel_id ORDER BY room_number) 
as next_room,
LEAD(room_number) OVER(PARTITION BY hotel_id ORDER BY room_number) - room_number AS diff
FROM table_ddl.hotels
WHERE available_status='true') t 
WHERE diff = 1;


---

SELECT hotel_id, room_number
FROM (
    SELECT
        hotel_id,
        room_number,
        available_status,
        LAG(room_number)  OVER (PARTITION BY hotel_id ORDER BY room_number) AS prev_room,
        LEAD(room_number) OVER (PARTITION BY hotel_id ORDER BY room_number) AS next_room,
        LAG(available_status)  OVER (PARTITION BY hotel_id ORDER BY room_number) AS prev_status,
        LEAD(available_status) OVER (PARTITION BY hotel_id ORDER BY room_number) AS next_status
    FROM table_ddl.hotels
) t
WHERE available_status = 'true'
  AND (
        (prev_status = 'true' AND room_number = prev_room + 1)
     OR (next_status = 'true' AND next_room = room_number + 1)
     OR (prev_status = 'true' AND room_number = prev_room)   -- handles duplicates like hotel 3
     OR (next_status = 'true' AND next_room = room_number)
  );
