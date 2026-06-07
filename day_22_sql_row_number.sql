-- Day 22 – SQL ROW_NUMBER()

-- This file focuses on:
-- - ROW_NUMBER()
-- - Sequential numbering
-- - Ranking records
-- - Department analysis
-- - Analytical reporting


USE company_db;


-- Q1.
-- Display:
-- - employee_name
-- - salary
-- - row number based on salary descending.
SELECT 
	emp_name,
    salary,
    ROW_NUMBER() OVER(ORDER BY salary DESC) AS row_num
FROM employees;


-- Q2.
-- Display:
-- - employee_name
-- - department_id
-- - salary
-- - row number within each department.

-- Highest salary should get row number 1.
SELECT 
	emp_name,
    department_id,
    salary,
    ROW_NUMBER() OVER(PARTITION BY department_id ORDER BY salary DESC) 
    AS row_num_within_department
FROM employees;

-- Q3.
-- Find the highest paid employee
-- in each department using ROW_NUMBER().
WITH cte_top AS(	
    SELECT 
		emp_name,
		department_id,
        department,
        salary,
		ROW_NUMBER() OVER(PARTITION BY department_id ORDER BY salary DESC)
		AS rank_row
	FROM employees
)
SELECT
    emp_name,
    department_id,
    department,
    salary
FROM cte_top
WHERE rank_row = 1;

-- Q4.
-- Find the second highest paid employee
-- in each department using ROW_NUMBER().
SELECT
    emp_name,
    department_id,
    department,
    salary
FROM (
    SELECT
        emp_name,
        department_id,
        department,
        salary,
        RANK() OVER(
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS rnk
    FROM employees
) t
WHERE rnk = 2;
	

-- Q5.
-- Display:
-- - project_name
-- - budget
-- - row number based on budget descending.
SELECT 
	project_id,
    project_name,
    budget,
    ROW_NUMBER() OVER(ORDER BY budget DESC)
    AS high_to_low
FROM projects;

-- Q6.
-- Display:
-- - employee_name
-- - city
-- - salary
-- - row number within each city.
SELECT 
	emp_name,
    city,
    salary,
    ROW_NUMBER() OVER(PARTITION BY city)
    AS number_within_city
FROM employees;

-- Q7.
-- Display:
-- - department_name
-- - employee_count
-- - row number based on employee count descending.
SELECT
    department,
    COUNT(*) AS employee_count,
    ROW_NUMBER() OVER(
        ORDER BY COUNT(*) DESC
    ) AS emp_count_rank
FROM employees
GROUP BY department;

-- Q8.
-- Find the top 3 highest paid employees
-- in the company using ROW_NUMBER().
WITH ranked_employees AS (
    SELECT
        emp_name,
        department_id,
        department,
        salary,
        ROW_NUMBER() OVER(
            ORDER BY salary DESC
        ) AS row_num
    FROM employees
)

SELECT
    emp_name,
    department_id,
    department,
    salary
FROM ranked_employees
WHERE row_num <= 3;


-- Q9.
-- Find the top 2 highest paid employees
-- from each department using ROW_NUMBER().
WITH top_2_higest_paid_emp AS (
	SELECT 
		emp_name,
        department,
        salary,
        ROW_NUMBER() OVER(ORDER BY salary DESC) AS salary_row_num
	FROM employees
)
SELECT 
	emp_name,
    department,
    salary
FROM top_2_higest_paid_emp
WHERE salary_row_num <= 2;

-- Q10.
-- Generate a workforce ranking report.

-- Display:
-- - employee_name
-- - department_name
-- - salary
-- - department_rank

-- Rank employees within their department
-- based on salary descending using ROW_NUMBER().
SELECT
    emp_name AS employee_name,
    department AS department_name,
    salary,
    ROW_NUMBER() OVER(
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS department_rank
FROM employees;
	