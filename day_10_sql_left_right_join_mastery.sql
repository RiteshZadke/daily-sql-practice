-- Day 10 – SQL LEFT JOIN / RIGHT JOIN

-- This file focuses on:
-- - LEFT JOIN
-- - RIGHT JOIN
-- - Missing relationships
-- - Unmatched record detection
-- - Data completeness analysis


USE company_db;

-- Q1.
-- Display:
-- - employee_name
-- - department_name
--
-- Include all employees even if
-- they do not belong to a department.
SELECT 
	e.emp_name,
    d.department_name
FROM employees e
LEFT JOIN departments d 
	ON e.department_id = d.department_id;

-- Q2.
-- Find employees who are not assigned
-- to any department.
SELECT e.*
FROM employees e
LEFT JOIN departments d 
	ON e.department_id = d.department_id
    WHERE e.department_id IS NULL;
    
-- Q3.
-- Display:
-- - department_name
-- - employee_name
--
-- Include all departments even if
-- no employee works in them.
SELECT
	e.emp_name,
    d.department_name
FROM employees e
RIGHT JOIN departments d 
	ON e.department_id = d.department_id;

-- Q4.
-- Find departments that currently
-- have no employees.
SELECT
	e.emp_name,
    d.department_name
FROM employees e
RIGHT JOIN departments d 
	ON e.department_id = d.department_id
    WHERE e.emp_id IS NULL;

-- Q5.
-- Display:
-- - department_name
-- - total employees
--
-- Include departments with zero employees.
SELECT 
	d.department_name,
    COUNT(e.emp_id) AS total_emp
FROM employees e
RIGHT JOIN departments d
	ON e.department_id = d.department_id
    GROUP BY d.department_id,d.department_name;
    
-- Q6.
-- Display all employees and their managers.
--
-- If manager information is unavailable,
-- still display employee details.
SELECT
    e.emp_name,
    d.manager_name
FROM employees e
LEFT JOIN departments d
    ON e.department_id = d.department_id;

-- Q7.
-- Find all departments located in Bangalore
-- and display employees working in them.
--
-- Include departments even if they have no employees.
SELECT 
	e.emp_id,
	d.department_name
FROM employees e 
lEFT JOIN departments d
	ON e.department_id = d.department_id
    AND d.location = 'Bangalore';
    
-- Q8.
-- Display:
-- - employee_name
-- - department_name
-- - location
--
-- Include every employee in the result.
SELECT 
	e.emp_name,
    d.department_name,
    d.location
FROM employees e
LEFT JOIN departments d 
	ON e.department_id = d.department_id;

-- Q9.
-- Find employees whose department details
-- are missing from the departments table.
SELECT e.*
FROM employees e
LEFT JOIN departments d
    ON e.department_id = d.department_id
WHERE d.department_id IS NULL;

-- Q10.
-- Generate a department staffing report.

-- Display:
-- - department_name
-- - location
-- - employee_count

-- Include all departments.
-- Sort by employee_count descending.

SELECT
    d.department_name,
    d.location,
    COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name, d.location
ORDER BY employee_count DESC;