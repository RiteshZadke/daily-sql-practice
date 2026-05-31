-- Day 15 – SQL String Functions

-- This file focuses on:
-- - String functions
-- - Text manipulation
-- - Formatting output
-- - Data cleaning
-- - Business reporting


USE company_db;


-- Q1.
-- Display employee names in uppercase.
SELECT 
	emp_name,
    UPPER(emp_name) AS emp_names_upper
FROM employees;

-- Q2.
-- Display employee names in lowercase.
SELECT 
	emp_name,
    LOWER(emp_name) AS emp_names_lower
FROM employees;

-- Q3.
-- Display:
-- - employee_name
-- - length of employee_name
SELECT 
	emp_name,
    LENGTH(emp_name) AS emp_names_length
FROM employees;

-- Q4.
-- Display first three characters
-- of each employee name.
SELECT 
	emp_name,
    LEFT(emp_name,3) AS emp_names_first_3
FROM employees;


-- Q5.
-- Display last three characters
-- of each employee name.
SELECT 
	emp_name,
    RIGHT(emp_name,3) AS emp_names_last_3
FROM employees;

-- Q6.
-- Display employee names with
-- leading and trailing spaces removed.

-- Use TRIM().
SELECT 
	emp_name,
    TRIM(emp_name) AS emp_names_trim
FROM employees;

-- Q7.
-- Display employee names and replace
-- all occurrences of the letter 'a'
-- with '*'.

-- Use REPLACE().
SELECT 
	emp_name,
    REPLACE(emp_name,'a','*') AS emp_names_repace
FROM employees;

-- Q8.
-- Create a formatted employee label.

-- Example:
-- Amit Sharma (IT)
SELECT 
	emp_name,
    CONCAT(emp_name,' ','(',department,')') AS emp_names_with_dep
FROM employees;

-- Q9.
-- Display employee names whose length
-- is greater than 10 characters.
SELECT
    emp_name
FROM employees
WHERE LENGTH(emp_name) > 10;

-- Q10.
-- Generate an employee directory report.

-- Display:
-- - employee_id
-- - employee_name
-- - department

-- Format output as:

-- [employee_id] - employee_name - department


SELECT 
	emp_id,
    emp_name,
    department,
    CONCAT('[',emp_id,']',' - ',emp_name,' - ',department) AS directory_report
FROM employees;