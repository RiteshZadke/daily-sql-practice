-- Day 23 – SQL RANK() & DENSE_RANK()

-- This file focuses on:
-- - RANK()
-- - DENSE_RANK()
-- - Salary ranking
-- - Department ranking
-- - Analytical reporting


USE company_db;


-- Q1.
-- Display:
-- - employee_name
-- - salary
-- - rank based on salary descending.

-- Use RANK().
SELECT 
	emp_name,
    salary,
    RANK() OVER(ORDER BY salary DESC) AS salary_rank
FROM employees;

-- Q2.
-- Display:
-- - employee_name
-- - salary
-- - dense_rank based on salary descending.

-- Use DENSE_RANK().
SELECT 
	emp_name,
    salary,
    DENSE_RANK() OVER(ORDER BY salary DESC) AS salary_rank
FROM employees;

-- Q3.
-- Display:
-- - employee_name
-- - department_id
-- - salary
-- - department_rank

-- Rank employees within each department.
SELECT 
	emp_name,
    department_id,
    salary,
    RANK() OVER(
		PARTITION BY department_id 
        ORDER BY salary DESC
        ) AS department_rank
FROM employees;

-- Q4.
-- Display:
-- - employee_name
-- - department_id
-- - salary
-- - department_dense_rank

-- Dense rank employees within
-- each department.
SELECT 
	emp_name,
    department_id,
    salary,
    DENSE_RANK() OVER(
		PARTITION BY department_id 
        ORDER BY salary DESC
	) AS department_dense_rank
FROM employees;


-- Q5.
-- Find the top salary employee(s)
-- from each department using RANK().
WITH top_salary_emps AS (
	SELECT 
		emp_name,
        department_id,
        salary,
        RANK() OVER(
			PARTITION BY department_id
			ORDER BY salary DESC
        ) AS department_rank
	FROM employees
)
SELECT 
	emp_name,
    department_id,
    salary
FROM top_salary_emps
WHERE department_rank = 1;

-- Q6.
-- Find the second highest salary employee(s)
-- from each department using DENSE_RANK().
WITH top_salary_emps AS (
	SELECT 
		emp_name,
        department_id,
        salary,
        DENSE_RANK() OVER(
			PARTITION BY department_id
			ORDER BY salary DESC
        ) AS department_dense_rank
	FROM employees
)
SELECT 
	emp_name,
    department_id,
    salary
FROM top_salary_emps
WHERE department_dense_rank = 2;

-- Q7.
-- Rank projects based on budget.

-- Display:
-- - project_name
-- - budget
-- - project_rank
SELECT
	project_name,
    budget,
    RANK() OVER(ORDER BY budget DESC) AS project_rank
FROM projects;

-- Q8.
-- Display:
-- - city
-- - employee_name
-- - salary
-- - city_salary_rank

-- Rank employees within each city.
SELECT
	city,
    emp_name,
    salary,
    RANK() OVER(
		PARTITION BY city
        ORDER BY salary DESC
	) AS city_salary_rank
    FROM employees;

-- Q9.
-- Generate a department salary leaderboard.

-- Display:
-- - department_name
-- - employee_name
-- - salary
-- - rank
SELECT
    department AS department_name,
    emp_name AS employee_name,
    salary,
    RANK() OVER(
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS rank_position
FROM employees
ORDER BY department_name, rank_position;

-- Q10.
-- Generate a workforce ranking report.

-- Display:
-- - employee_name
-- - department_name
-- - salary
-- - rank
-- - dense_rank

-- Sort by salary descending.
SELECT
    emp_name AS employee_name,
    department AS department_name,
    salary,

    RANK() OVER(
        ORDER BY salary DESC
    ) AS rank_position,

    DENSE_RANK() OVER(
        ORDER BY salary DESC
    ) AS dense_rank_position

FROM employees
ORDER BY salary DESC;