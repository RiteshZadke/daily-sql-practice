-- Day 31 – SQL Views

-- This file focuses on:
-- - Views
-- - Virtual Tables
-- - Data Abstraction
-- - Reusable Queries
-- - Reporting


USE company_db;


-- Q1.
-- Create a view named high_salary_employees.

-- Include employees earning
-- more than 70000.
CREATE VIEW high_salary_employees AS
SELECT 
	emp_name,
    department_id,
    salary
FROM employees
WHERE salary > 70000;

-- Q2.
-- Display all records from
-- high_salary_employees.
SELECT * 
FROM high_salary_employees;

-- Q3.
-- Create a view containing:

-- - employee_name
-- - department_name
-- - salary

-- using JOINs.
CREATE VIEW emp_dep AS
SELECT 
	e.emp_name,
    d.department_name,
    e.salary
FROM employees e
LEFT JOIN departments d
	ON e.department_id = d.department_id;
    
SELECT *
FROM emp_dep;

-- Q4.
-- Create a view named
-- department_salary_summary.

-- Include:
-- - department_name
-- - employee_count
-- - average_salary

CREATE VIEW department_salary_summary AS
SELECT 
	d.department_name,
    COUNT(e.emp_id) AS employee_count,
    AVG(salary) AS average_salary
FROM departments d
INNER JOIN employees e
	ON d.department_id = e.department_id
GROUP BY d.department_name,d.department_id;



-- Q5.
-- Display departments whose
-- average salary exceeds 60000
-- using the view.
SELECT
	department_name,
    employee_count,
    average_salary
FROM department_salary_summary
WHERE average_salary > 60000;

-- Q6.
-- Create a project analytics view.

-- Include:
-- - project_name
-- - budget
-- - employee_count
CREATE VIEW project_analytics AS
SELECT 
	p.project_name,
    p.budget,
    COUNT(ep.employee_id) AS employee_count
FROM projects p
INNER JOIN employee_projects ep
	ON p.project_id = ep.project_id
GROUP BY p.project_name,p.project_id;

SELECT * FROM project_analytics;

-- Q7.
-- Create a city workforce view.

-- Include:
-- - city
-- - employee_count
-- - average_salary
CREATE VIEW city_workforce AS
SELECT 
	city,
    COUNT(*) AS employee_count,
    AVG(salary) AS average_salary
FROM employees
GROUP BY city;
SELECT * FROM city_workforce;

-- Q8.
-- Modify an existing view.

-- Add an additional column
-- to the view definition.
CREATE OR REPLACE VIEW employee_details AS
SELECT
    emp_id,
    emp_name,
    salary,
    department_id
FROM employees;

-- Q9.
-- Drop a view safely.

-- Verify that the underlying
-- table data remains intact.

-- Drop the view safely
DROP VIEW IF EXISTS high_salary_employees;

-- Verify base table data remains intact
SELECT *
FROM employees;

-- Q10.
-- Create an executive dashboard view.

-- Include:
-- - department_name
-- - employee_count
-- - average_salary
-- - highest_salary
-- - total_salary

CREATE VIEW executive_dashboard AS
SELECT
    d.department_name,
    COUNT(e.emp_id) AS employee_count,
    AVG(e.salary) AS average_salary,
    MAX(e.salary) AS highest_salary,
    SUM(e.salary) AS total_salary
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
GROUP BY
    d.department_id,
    d.department_name;