-- ============================================
-- Day 02 – SQL ORDER BY, LIMIT, DISTINCT
-- ============================================

-- This file contains 10 practice problems focused on:

-- - ORDER BY
-- - LIMIT
-- - DISTINCT
-- - Sorting records
-- - Top-N queries
-- - Query readability


-- LAB RULES (READ FIRST)

-- - Each question is independent
-- - Write readable SQL queries
-- - Use proper indentation
-- - Avoid unnecessary complexity
-- - Focus on sorting logic


USE company_db;


-- Q1.
-- Display all employees sorted by salary in ascending order.
SELECT * 
FROM employees
ORDER BY salary ASC;

-- Q2.
-- Display all employees sorted by salary in descending order.
SELECT *
FROM employees
ORDER BY salary DESC;

-- Q3.
-- Display employee names and ages sorted by age from youngest to oldest.
SELECT emp_name,age
FROM employees
ORDER BY age ASC;

-- Q4.
-- Display top 5 highest paid employees.
SELECT *
FROM employees
ORDER BY salary DESC LIMIT 5;

-- Q5.
-- Display top 3 youngest employees.
SELECT *
FROM employees
ORDER BY age ASC LIMIT 3;

-- Q6.
-- Display all unique city names from the employees table.
SELECT DISTINCT city 
FROM employees;

-- Q7.
-- Display all unique department names sorted alphabetically.
SELECT DISTINCT department 
FROM employees
ORDER BY department ASC;

-- Q8.
-- Display employee name, department, and salary.
-- Sort first by department ascending
-- and then by salary descending.
SELECT 
emp_name,
department,
salary
FROM employees
ORDER BY department ASC ,salary DESC;

-- Q9.
-- Display 5 employees with the lowest salaries.
SELECT * 
FROM employees
ORDER BY salary ASC LIMIT 5;

-- Q10.
-- Display distinct combinations of:
-- - department
-- - city
-- from the employees table.
SELECT DISTINCT 
department,
city
FROM employees;