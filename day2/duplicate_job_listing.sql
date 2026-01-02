--Assume you're given a table containing job postings from various companies on the LinkedIn platform.
-- Write a query to retrieve the count of companies that have posted duplicate job listings.

WITH DuplicateJobs AS (
    SELECT 
        company_id,
        job_title,
        COUNT(*) AS job_count
    FROM 
        job_listings
    GROUP BY 
        company_id, job_title
    HAVING 
        COUNT(*) > 1
)

SELECT 
    COUNT(DISTINCT company_id) AS duplicate_company_count
FROM 
    DuplicateJobs;

-- using self join 

SELECT 
COUNT(DISTINCT company_id) as duplicate_companies
--jl1.job_id,jl1.company_id,jl1.title,jl1.description,
--jl2.job_id as job_id_2,jl2.company_id as company_id_2,jl2.title as title_2,jl2.description as description_2
from job_listings jl1 
JOIN job_listings jl2
ON jl1.company_id = jl2.company_id 
WHERE jl1.job_id < jl2.job_id 
AND jl1.title=jl2.title 
AND jl1.description = jl2.description