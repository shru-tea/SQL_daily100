/* 
It's not random. Someone is hitting the city again and again. 
Find the suspects linked to multiple incidents.
*/

SELECT s.suspect_id, s.name,
COUNT(i.incident_id) AS incident_count
FROM suspects s 
LEFT JOIN incidents i 
ON s.suspect_id = i.suspect_id
WHERE i.suspect_id IS NOT NULL
GROUP BY 1,2
HAVING COUNT(i.incident_id) >1
ORDER BY COUNT(i.incident_id) DESC;

/*
There's a pattern in weapon choice. 
Let's see which weapons are used most frequently and by which suspects.
*/
SELECT weapon_used,
COUNT(*) AS usage_count
FROM incidents
GROUP BY weapon_used
ORDER BY COUNT(*) DESC;

/*
Serial attackers often strike at specific times. 
Let's analyze the time patterns to predict when the next attack might occur.
*/

-- important to have ELSE in CASE statements to cover all time ranges

SELECT 
  CASE
    WHEN time_of_day >= '22:00' OR time_of_day < '06:00' THEN 'Night'
    WHEN time_of_day >= '06:00' AND time_of_day < '12:00' THEN 'Morning'
    WHEN time_of_day >= '12:00' AND time_of_day < '18:00' THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_period,
  COUNT(*) AS incident_count
FROM incidents
GROUP BY
  CASE
    WHEN time_of_day >= '22:00' OR time_of_day < '06:00' THEN 'Night'
    WHEN time_of_day >= '06:00' AND time_of_day < '12:00' THEN 'Morning'
    WHEN time_of_day >= '12:00' AND time_of_day < '18:00' THEN 'Afternoon'
    ELSE 'Evening'
  END
ORDER BY incident_count DESC;

/* Victomlogy profile - Serial attackers often target specific victim demographics. 
Let's analyze the age patterns of victims to understand the predator's preferences.*/

SELECT 
CASE 
  WHEN victim_age < 25 THEN 'Young Adult'
  WHEN victim_age >=25 AND victim_age < 35 THEN 'Adult'
  ELSE 'Older Adult'
END AS age_group,
COUNT(*) AS victim_count,
AVG(victim_age) as avg_age
FROM incidents
GROUP BY CASE 
  WHEN victim_age < 25 THEN 'Young Adult'
  WHEN victim_age >=25 AND victim_age < 35 THEN 'Adult'
  ELSE 'Older Adult'
END
ORDER BY COUNT(*) DESC;

/* Severity analysis - 
Serial attackers often escalate their violence over time. 
Let's check if injury severity is increasing with each incident.
*/

SELECT s.suspect_id, s.name,
AVG(i.injury_severity) AS avg_severity,
MAX(i.injury_severity) AS max_severity,
COUNT(i.incident_id) AS incident_count
FROM suspects s 
LEFT JOIN incidents i 
ON s.suspect_id = i.suspect_id
WHERE i.suspect_id IS NOT NULL
GROUP BY 1,2
HAVING COUNT(i.incident_id) > 1
ORDER BY AVG(i.injury_severity) desc;

/* Geographic clustering -Let's map the predator's hunting grounds. 
Analyze which locations and security levels are being targeted most frequently.
*/

SELECT 
l.security_level,
l.foot_traffic,
COUNT(i.incident_id) AS incident_count
FROM incidents i 
LEFT JOIN locations l 
ON i.location = l.area_name
WHERE l.area_name IS NOT NULL
GROUP BY 1,2
ORDER BY COUNT(i.incident_id) DESC;

/* Signature behaviors - Every serial attacker has unique signature behaviors. 
Let's identify any recurring patterns in the methods or rituals used. 
 Isolate the specific weapon, time, and victim type that defines this monster.*/

SELECT 
weapon_used,
 CASE
    WHEN time_of_day >= '22:00' OR time_of_day < '06:00' THEN 'Night'
    WHEN time_of_day >= '06:00' AND time_of_day < '12:00' THEN 'Morning'
    WHEN time_of_day >= '12:00' AND time_of_day < '18:00' THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_period,
CASE 
  WHEN victim_age < 25 THEN 'Young Adult'
  WHEN victim_age >=25 AND victim_age < 35 THEN 'Adult'
  ELSE 'Older Adult'
END AS victim_type,
COUNT(*) AS pattern_count
FROM incidents
WHERE suspect_id = 101
GROUP BY 1,2,3
ORDER BY COUNT(*) DESC
  -- OR 

SELECT 
weapon_used,
 CASE
    WHEN time_of_day >= '22:00' THEN 'Night'
    ELSE 'Day'
  END AS time_period,
CASE 
  WHEN victim_age < 25 THEN 'Young'
  ELSE 'Older'
END AS victim_type,
COUNT(*) AS pattern_count
FROM incidents
WHERE suspect_id = 101
GROUP BY 1,2,3
ORDER BY COUNT(*) DESC;

/* cooling off period -
Serial attackers often have cooling-off periods between crimes. Let's analyze
 the time gaps between Marcus Steele's attacks to predict the next one. */

select
COUNT(*) AS incident_count,
MIN(incident_id) AS first_incident,
MAX(incident_id) AS last_incident
FROM incidents
WHERE suspect_id = 101;

/* Accomplice analysis -Some attacks might involve accomplices. 
Let's see if any suspects operate in the same areas or use similar methods, suggesting coordination.
*/

SELECT i1.suspect_id AS suspect1,
i2.suspect_id AS suspect2,
COUNT(*) AS shared_patterns
FROM incidents i1 
JOIN incidents i2
ON i1.location = i2.location
AND i1.weapon_used = i2.weapon_used
AND i1.suspect_id < i2.suspect_id
GROUP BY i1.suspect_id,i2.suspect_id
HAVING COUNT(*)>1
ORDER BY COUNT(*) DESC;

/* the predator profile - Time to build the complete behavioral profile. 
Create a comprehensive analysis showing suspect patterns, 
escalation trends, and risk assessment for prosecution.

We have him. Build the final predator profile for Marcus Steele (ID 101). 
Generate a comprehensive report including `name`, `age`, `arrest_count`, 
`total_incidents`, `avg_severity`, `max_severity`, `knife_attacks`, 
`night_attacks`, and `young_victims`.
*/

SELECT 
s.name, s.age, s.arrest_count,
COUNT(i.incident_id) AS total_incident,
AVG(i.injury_severity) AS avg_severity,
MAX(i.injury_severity) AS max_severity,
SUM(CASE WHEN i.weapon_used = 'Knife' THEN 1 ELSE 0 END) AS knife_attacks,
SUM(CASE
    WHEN i.time_of_day >= '22:00' THEN 1
    ELSE 0
  END) AS night_attacks,
SUM(CASE 
  WHEN i.victim_age < 25 THEN 1
  ELSE 0
END) AS young_victims
FROM suspects s 
LEFT JOIN incidents i 
ON s.suspect_id = i.suspect_id
WHERE s.suspect_id = 101
GROUP BY 1,2,3
;


SELECT s.name, s.age, s.arrest_count, 
COUNT(i.incident_id) AS total_incidents, 
AVG(i.injury_severity) AS avg_severity, 
MAX(i.injury_severity) AS max_severity, 
COUNT(CASE WHEN i.weapon_used = 'Knife' THEN 1 END) AS knife_attacks, 
COUNT(CASE WHEN i.time_of_day >= '22:00' THEN 1 END) AS night_attacks, 
COUNT(CASE WHEN i.victim_age < 25 THEN 1 END) AS young_victims 
FROM suspects s JOIN incidents i ON s.suspect_id = i.suspect_id 
WHERE s.suspect_id = 101 
GROUP BY s.suspect_id, s.name, s.age, s.arrest_count;