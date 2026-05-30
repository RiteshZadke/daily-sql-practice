-- Day 14 – SQL UNION / UNION ALL

-- This file focuses on:
-- - UNION
-- - UNION ALL
-- - Combining result sets
-- - Duplicate handling
-- - Multi-source reporting


USE company_db;

-- Assumed Additional Tables:
--
-- current_employees
-- former_employees
--
-- current_projects
-- archived_projects


-- Q1.
-- Display employee names from:
-- - current_employees
-- - former_employees

-- using UNION.
SELECT emp_name 
FROM current_employees
UNION
SELECT emp_name
FROM former_employees;

-- Q2.
-- Repeat Q1 using UNION ALL.
-- Compare the result.
SELECT emp_name 
FROM current_employees
UNION ALL
SELECT emp_name
FROM former_employees;

-- Q3.
-- Display all cities from:
-- - employees
-- - departments
-- using UNION.
SELECT city 
FROM employees
UNION
SELECT location
FROM departments; 

-- Q4.
-- Display all department names from:
-- - active departments
-- - archived departments
SELECT department_name
FROM departments
UNION
SELECT department_name
FROM archived_departments;

-- Q5.
-- Display project names from:
-- - current_projects
-- - archived_projects
-- using UNION ALL.
SELECT project_name
FROM current_projects
UNION ALL
SELECT project_name
FROM archived_projects;

-- Q6.
-- Create a combined employee list containing:
-- - employee_id
-- - employee_name
-- from both current and former employees.
SELECT 
	emp_id,
    emp_name
FROM current_employees
UNION ALL
SELECT 
    emp_id,
    emp_name
FROM former_employees;

-- Q7.
-- Display all manager names and employee names
-- in a single result set using UNION.
SELECT emp_name AS employee_name
FROM employees
UNION
SELECT manager_name AS employee_name
FROM departments;

-- Q8.
-- Create a unified location report using:
-- - employee cities
-- - department locations
-- Remove duplicates.
SELECT city AS city
FROM employees
UNION
SELECT location AS city
FROM departments;

-- Q9.
-- Display:
-- - project_name
-- - budget

-- from:
-- - current_projects
-- - archived_projects

-- using UNION ALL.
SELECT 
	project_name,
    budget
FROM current_projects
UNION ALL
SELECT
	project_name,
    budget
FROM archived_projects;

-- Q10.
-- Generate a workforce summary report.

-- Combine:
-- - current employees
-- - former employees

-- Display:
-- - employee_id
-- - employee_name
-- - source_type

-- source_type should indicate:
-- 'Current'
-- 'Former'

SELECT 
	emp_id,
    emp_name,
    'Current' AS source_type
FROM current_employees
UNION ALL
SELECT 
	emp_id,
    emp_name,
    'Former' AS source_type
FROM former_employees;