-- Day 27 – SQL PARTITION BY Practice

-- This file focuses on:
-- - PARTITION BY
-- - Department Analytics
-- - Group-wise Analysis
-- - Window Aggregations
-- - Advanced Reporting


USE company_db;


-- Q1.
-- Display:
-- - employee_name
-- - department_id
-- - salary
-- - department_average_salary

-- Use PARTITION BY department_id.
SELECT
	emp_name,
    department_id,
    salary,
    AVG(salary) OVER(
		PARTITION BY department_id
	) AS department_average_salary
FROM employees;

-- Q2.
-- Display:
-- - employee_name
-- - department_id
-- - salary
-- - department_max_salary

-- Use PARTITION BY department_id.
SELECT
	emp_name,
    department_id,
    salary,
    MAX(salary) OVER(
		PARTITION BY department_id
	) AS department_max_salary
FROM employees;

-- Q3.
-- Display:
-- - employee_name
-- - city
-- - salary
-- - city_average_salary

-- Use PARTITION BY city.
SELECT 
	emp_name,
    city,
    salary,
    AVG(salary) OVER(
		PARTITION BY city
	) AS city_average_salary
FROM employees;

-- Q4.
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
    
-- Q5.
-- Display:
-- - employee_name
-- - city
-- - salary
-- - city_rank

-- Rank employees within each city.
SELECT
	emp_name,
    city,
    salary,
    RANK() OVER(
		PARTITION BY city
        ORDER BY salary DESC
	) AS city_rank
FROM employees;
    
-- Q6.
-- Display:
-- - project_name
-- - budget
-- - budget_rank

-- Rank projects by budget.
SELECT 
	project_name,
    budget,
    RANK() OVER(
		ORDER BY budget DESC
	) AS budget_rank
FROM projects;

-- Q7.
-- Display:
-- - employee_name
-- - department_id
-- - salary
-- - running_department_salary

-- Calculate running totals
-- within each department.
SELECT 
	emp_name,
    department_id,
    salary,
    SUM(salary) OVER(
		PARTITION BY department_id
        ORDER BY salary ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	) AS running_department_salary
FROM employees;

-- Q8.
-- Display:
-- - city
-- - employee_name
-- - salary
-- - running_city_salary

-- Calculate running totals
-- within each city.
SELECT 
	city,
    emp_name,
    salary,
    SUM(salary) OVER(
		PARTITION BY city
        ORDER BY salary DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	) AS running_city_salary
FROM employees;

-- Q9.
-- Generate a department performance report.

-- Display:
-- - department_name
-- - employee_name
-- - salary
-- - department_average_salary
-- - department_max_salary
-- - department_rank
SELECT 
	department,
    emp_name,
    salary,
    AVG(salary) OVER(
		PARTITION BY department
	) AS department_average_salary,
    MAX(salary) OVER(
		PARTITION BY department
	) AS department_max_salary,
    RANK() OVER(
		PARTITION BY department
        ORDER BY salary DESC
	) AS department_rank
FROM employees;

-- Q10.
-- Generate an executive workforce report.

-- Display:
-- - employee_name
-- - department_name
-- - city
-- - salary
-- - department_rank
-- - city_rank
-- - department_average_salary
-- - city_average_salary

-- Sort by salary descending.
SELECT 
	emp_name,
    department,
    city,
    salary,
    RANK() OVER(
		PARTITION BY department
        ORDER BY salary DESC
	) AS department_rank,
    RANK() OVER(
		PARTITION BY city
        ORDER BY salary DESC
	) AS city_rank,
    AVG(salary) OVER(
		PARTITION BY department
	) AS department_average_salary,
    AVG(salary) OVER(
		PARTITION BY city
	) AS city_average_salary
FROM employees;