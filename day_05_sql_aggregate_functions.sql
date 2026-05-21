-- ============================================
-- Day 05 – SQL Aggregate Functions
-- ============================================

-- This file contains 10 practice problems focused on:

-- - COUNT()
-- - SUM()
-- - AVG()
-- - MIN()
-- - MAX()
-- - basic data summarization


USE company_db;


-- Q1.
-- Find the total number of employees in the company.
SELECT COUNT(*) AS total_emp
FROM employees;

-- Q2.
-- Find the total salary paid to all employees.
SELECT SUM(salary) AS total_sal
FROM employees;

-- Q3.
-- Find the average salary of employees.
SELECT AVG(salary) AS avg_sal
FROM employees;

-- Q4.
-- Find the highest salary in the company.
SELECT MAX(salary) AS max_sal
FROM employees;

-- Q5.
-- Find the lowest salary in the company.
SELECT MIN(salary) AS min_sal
FROM employees;

-- Q6.
-- Find the total number of employees working in the IT department.
SELECT COUNT(*) AS total_emp
FROM employees
WHERE department = 'IT';

-- Q7.
-- Find the average experience of all employees.
SELECT AVG(experince) AS avg_exp
FROM employees;

-- Q8.
-- Find the total salary paid to employees who belong to Mumbai.
SELECT SUM(salary) AS total_sal
FROM employees
WHERE city = 'Mumbai';

-- Q9.
-- Find the highest salary among employees in the Finance department.
SELECT MAX(salary) AS max_sal
FROM employees
WHERE department = 'Finance';

-- Q10.
-- Find the minimum, maximum, and average age of employees in a single query.
SELECT 
	MIN(age) AS MIN_AGE,
    MAX(age) AS max_age,
    AVG(age) AS avg_age
FROM employees;