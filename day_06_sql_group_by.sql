-- Day 06 – SQL GROUP BY

-- This file focuses on:
-- - GROUP BY
-- - Aggregation by categories
-- - Business summaries
-- - Group-level analysis
-- - Understanding grouped results

USE company_db;


-- Q1.
-- Find the total number of employees in each department.
SELECT 
	department,
    COUNT(*) AS emp_count
FROM employees
GROUP BY department;

-- Q2.
-- Find the average salary of employees in each department.
SELECT 
	department,
    AVG(salary) AS avg_sal
FROM employees
GROUP BY department;

-- Q3.
-- Find the highest salary in each department.
SELECT 
	department,
    MAX(salary) AS max_sal
FROM employees
GROUP BY department;

-- Q4.
-- Find the minimum salary in each department.
SELECT 
	department,
    MIN(salary) AS min_sal
FROM employees
GROUP BY department;

-- Q5.
-- Find the total salary paid in each department.
SELECT 
	department,
    SUM(salary) AS total_sal
FROM employees
GROUP BY department;

-- Q6.
-- Find the total number of employees in each city.
SELECT 
	city,
    COUNT(*) AS emp_count
FROM employees
GROUP BY city;

-- Q7.
-- Find the average experience of employees in each city.
SELECT 
	city,
    AVG(experince) AS avg_exp
FROM employees
GROUP BY city;

-- Q8.
-- Find the highest salary earned in each city.
SELECT 
	city,
    MAX(salary) AS max_sal
FROM employees
GROUP BY city;

-- Q9.
-- Find the total salary paid to employees in each city.
SELECT 
	city,
    SUM(salary) AS total_sal
FROM employees
GROUP BY city;

-- Q10.
-- Find:
-- - department
-- - total employees
-- - average salary
-- - maximum salary

-- for every department in a single query.
SELECT 
	department,
    COUNT(*) AS total_emp,
    AVG(salary) AS avg_sal,
    MAX(salary) AS max_sal
FROM employees
GROUP BY department;