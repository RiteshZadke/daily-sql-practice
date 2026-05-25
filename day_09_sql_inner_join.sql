-- Day 09 – SQL INNER JOIN

-- This file focuses on:
-- - INNER JOIN
-- - Relational database concepts
-- - Primary and foreign keys
-- - Combining data from tables
-- - Business reporting queries


-- LAB RULES (READ FIRST)

-- - Each question is independent
-- - Use proper JOIN syntax
-- - Avoid old-style joins
-- - Focus on relationship understanding
-- - Write readable SQL queries


USE company_db;

-- Q1.
-- Display:
-- - employee_name
-- - department_name

-- using INNER JOIN.
SELECT 
	e.emp_name,
    d.department_name
FROM employees e
INNER JOIN departments d
	ON e.department_id = d.department_id;

-- Q2.
-- Display:
-- - employee_id
-- - employee_name
-- - department_name
-- - salary
SELECT 
	e.emp_name,
    e.emp_id,
    d.department_name,
    e.salary
FROM employees e
INNER JOIN departments d 
	ON e.department_id = d.department_id;

-- Q3.
-- Display all employees working in the IT department.
SELECT *
FROM employees e
INNER JOIN departments d 
	 ON e.department_id = d.department_id
     WHERE d.department_name = 'IT';

-- Q4.
-- Display employees whose salary is greater than 60000
-- along with their department names.
SELECT 
	e.emp_name,
    d.department_name
FROM employees e
INNER JOIN departments d 
	 ON e.department_id = d.department_id
     WHERE e.salary > 60000;

-- Q5.
-- Display:
-- - employee_name
-- - city
-- - department_name

-- sorted by department name.
SELECT 
	e.emp_name,
    e.city,
    d.department_name
FROM employees e
INNER JOIN departments d 
	ON e.department_id = d.department_id
    ORDER BY d.department_name ASC ;

-- Q6.
-- Count the number of employees in each department.
SELECT 
	d.department_name,
	COUNT(*) AS emp_count
FROM employees e
JOIN departments d 
	ON e.department_id = d.department_id
    GROUP BY d.department_name;
    
-- Q7.
-- Find the average salary of employees
-- in each department.
SELECT 
	d.department_name,
	AVG(salary) AS avg_salary
FROM employees e
JOIN departments d 
	ON e.department_id = d.department_id
    GROUP BY d.department_name;

-- Q8.
-- Find the highest salary in each department.
SELECT 
	d.department_name,
	MAX(salary) AS max_salary
FROM employees e
JOIN departments d 
	ON e.department_id = d.department_id
    GROUP BY d.department_name;

-- Q9.
-- Display employees having more than 5 years
-- of experience along with department names.
SELECT 
	e.emp_name,
    e.experince,
    d.department_name
FROM employees e
INNER JOIN departments d
	ON e.department_id = d.department_id
    WHERE e.experince > 5;

-- Q10.
-- Display:
-- - department_name
-- - total employees
-- - average salary
-- - highest salary

-- for every department.
SELECT 
	d.department_name,
    COUNT(*) AS total_emp,
    AVG(e.salary) AS avg_salary,
	MAX(salary) AS max_salary
FROM employees e
JOIN departments d 
	ON e.department_id = d.department_id
    GROUP BY d.department_name;