-- Day 16 – SQL Date Functions

-- This file focuses on:
-- - Date functions
-- - Date calculations
-- - Time-based reporting
-- - Business date analysis
-- - Temporal data handling


USE company_db;

-- Assumed Table:
--
-- projects
-- (
--     project_id,
--     project_name,
--     budget,
--     start_date,
--     end_date
-- )


-- Q1.
-- Display the current date.
SELECT CURDATE();

-- Q2.
-- Display the current timestamp.
SELECT NOW();

-- Q3.
-- Display:
-- - project_name
-- - start_date
-- - year of start_date
SELECT 
	project_name,
    start_date,
    YEAR(start_date) AS start_year
FROM projects;

-- Q4.
-- Display:
-- - project_name
-- - start_date
-- - month of start_date
SELECT 
	project_name,
    start_date,
    MONTH(start_date) AS start_month
FROM projects;

-- Q5.
-- Display:
-- - project_name
-- - start_date
-- - day of month
SELECT
	project_name,
    start_date,
    DAY(start_date) AS start_day
FROM projects;

-- Q6.
-- Find projects that started
-- in the current year.
SELECT 
	project_name,
    start_date
FROM projects
WHERE YEAR(start_date) = YEAR(CURDATE());

-- Q7.
-- Find projects whose start month
-- is January.
SELECT
	project_name,
    start_date
FROM projects
WHERE MONTH(start_date) = 1;

-- Q8.
-- Calculate project duration in days.

-- Display:
-- - project_name
-- - duration_days
SELECT 
	project_name,
    DATEDIFF(end_date,start_date) AS duration_days
FROM projects;

-- Q9.
-- Find projects that last
-- more than 180 days.
SELECT 
	project_name
FROM projects
WHERE DATEDIFF(end_date,start_date) > 180;

-- Q10.
-- Generate a project timeline report.

-- Display:
-- - project_name
-- - start_date
-- - end_date
-- - duration_days
-- - start_year
-- - start_month

-- Sort by project duration descending.
SELECT 
	project_name,
    start_date,
    end_date,
    DATEDIFF(end_date,start_date) AS duration_days,
    YEAR(start_date) AS start_year,
    MONTH(start_date) AS start_month
FROM projects
ORDER BY DATEDIFF(end_date,start_date) DESC;