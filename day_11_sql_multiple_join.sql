-- Day 11 – SQL Multiple JOINs

-- This file focuses on:
-- - Multiple JOINs
-- - Multi-table relationships
-- - Combining business data
-- - Relational thinking
-- - Join chain analysis

USE company_db;


-- Q1.
-- Display:
-- - employee_name
-- - department_name
-- - location
--
-- using employees and departments tables.
SELECT
	e.emp_name,
    d.department_name,
    d.location
FROM employees e
LEFT JOIN departments d 
	ON e.department_id = d.department_id;

-- Q2.
-- Display:
-- - employee_name
-- - project_name
--
-- using employees, employee_projects
-- and projects tables.
SELECT
    e.emp_name,
    p.project_name
FROM employees e
LEFT JOIN employee_projects ep
    ON e.emp_id = ep.employee_id
LEFT JOIN projects p
    ON ep.project_id = p.project_id;

-- Q3.
-- Display:
-- - employee_name
-- - department_name
-- - project_name
SELECT
    e.emp_name,
    d.department_name,
    p.project_name
FROM employees e
LEFT JOIN departments d
    ON e.department_id = d.department_id
LEFT JOIN employee_projects ep
    ON e.emp_id = ep.employee_id
LEFT JOIN projects p
    ON ep.project_id = p.project_id;

-- Q4.
-- Find all employees working in
-- the IT department and show
-- their assigned projects.
SELECT
    e.emp_name,
    p.project_name
FROM employees e
INNER JOIN departments d
    ON e.department_id = d.department_id
LEFT JOIN employee_projects ep
    ON e.emp_id = ep.employee_id
LEFT JOIN projects p
    ON ep.project_id = p.project_id
WHERE d.department_name = 'IT';

-- Q5.
-- Display:
-- - department_name
-- - project_name
-- - employee_name

-- for all project assignments.
SELECT 
    e.emp_name,
    d.department_name,
    p.project_name
FROM employees e
LEFT JOIN departments d
    ON e.department_id = d.department_id
LEFT JOIN employee_projects ep
    ON e.emp_id = ep.employee_id
LEFT JOIN projects p
    ON ep.project_id = p.project_id;

-- Q6.
-- Count how many employees are assigned
-- to each project.
SELECT
    p.project_name,
    COUNT(ep.employee_id) AS assigned_emp
FROM projects p
LEFT JOIN employee_projects ep
    ON p.project_id = ep.project_id
GROUP BY p.project_id, p.project_name;

-- Q7.
-- Find the average salary of employees
-- working on each project.
SELECT 
	p.project_name,
    AVG(e.salary) AS avg_salary
FROM employees e
LEFT JOIN employee_projects ep
	ON e.emp_id = ep.employee_id
LEFT JOIN projects p
	ON ep.project_id = p.project_id
GROUP BY p.project_id;

-- Q8.
-- Display employees working on projects
-- whose budget exceeds 500000.
SELECT
	e.emp_id,
	e.emp_name,
    p.project_name
FROM employees e 
LEFT JOIN employee_projects ep
	ON e.emp_id = ep.employee_id
LEFT JOIN projects p
	ON ep.project_id = p.project_id
WHERE p.budget > 500000;

-- Q9.
-- Display:
-- - employee_name
-- - department_name
-- - manager_name
-- - project_name

-- in a single query.
SELECT 
	e.emp_name,
    d.department_name,
    d.manager_name,
    p.project_name
FROM employees e
LEFT JOIN departments d 
	ON e.department_id = d.department_id
LEFT JOIN employee_projects ep
	ON e.emp_id = ep.employee_id
LEFT JOIN projects p
	ON ep.project_id = p.project_id;

-- Q10.
-- Generate a project staffing report.

-- Display:
-- - project_name
-- - total_employees
-- - average_salary
-- - highest_salary

-- Sort by total_employees descending.
SELECT 
    p.project_name,
    COUNT(e.emp_id) AS total_employees,
    AVG(e.salary) AS average_salary,
    MAX(e.salary) AS highest_salary
FROM employees e
LEFT JOIN employee_projects ep
    ON e.emp_id = ep.employee_id
LEFT JOIN projects p
    ON ep.project_id = p.project_id
GROUP BY p.project_id, p.project_name
ORDER BY total_employees DESC;