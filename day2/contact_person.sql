--Check if the same contact person is running multiple 'competing' companies. That's a classic shell game.
--Expose the shell game. Find any `contact_person` linked to multiple different vendor records. List their `contact_person` name and the two vendor names (aliased as `vendor1` and `vendor2`). Ensure each pair is listed only once (use `a.name < b.name`).


--self join approach
--A Self-Join is when you join a table to itself. This is useful for finding relationships within the same dataset, like finding duplicates or comparing rows. To avoid listing the same pair twice (A-B and B-A), we use a 'less than' condition in the JOIN logic.

SELECT 
v2.contact_person, v1.name as vendor1, v2.name as vendor2
from vendors v1 
JOIN vendors v2
ON v1.contact_person = v2.contact_person
WHERE v1.vendor_id > v2.vendor_id;