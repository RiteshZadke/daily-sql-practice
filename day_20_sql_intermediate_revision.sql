-- Day 20 – SQL Intermediate Revision

-- This file focuses on:
-- - Aggregations
-- - JOINs
-- - Subqueries
-- - CTEs
-- - Reporting
-- - Analytical Thinking


USE company_db;


-- Q1.
-- Display:
-- - employee_name
-- - department_name
-- - salary

-- Sort by salary descending.
SELECT 
	emp_id,
    emp_name,
    department,
    salary
FROM employees 
ORDER BY salary DESC;

-- Q2.
-- Find the top 5 highest paid employees.
SELECT 
	emp_id,
    emp_name,
    department,
    salary
FROM employees 
ORDER BY salary DESC
LIMIT 5;

-- Q3.
-- Display department-wise:

-- - employee_count
-- - average_salary
-- - maximum_salary
-- - minimum_salary
SELECT 
	d.department_id,
    d.department_name,
    COUNT(e.emp_id) AS employee_count,
    AVG(e.salary) AS average_salary,
    MAX(e.salary) AS maximum_salary,
    MIN(e.salary) AS minimum_salary
FROM employees e
LEFT JOIN departments d
	ON e.department_id = d.department_id
GROUP BY d.department_id,d.department_name;

-- Q4.
-- Find employees earning more than
-- the company average salary.
SELECT *
FROM employees
WHERE salary > (
	SELECT AVG(salary)
    FROM employees
);

-- Q5.
-- Display projects having more than
-- 2 employees assigned.

WITH project_emp AS (
    SELECT
        p.project_id,
        p.project_name,
        COUNT(ep.employee_id) AS emp_count
    FROM projects p
    LEFT JOIN employee_projects ep
        ON p.project_id = ep.project_id
    GROUP BY p.project_id, p.project_name
)

SELECT *
FROM project_emp
WHERE emp_count > 2;

-- Q6.
-- Find employees assigned to
-- multiple projects.
SELECT
	e.emp_id,
    e.emp_name,
    COUNT(p.project_id)	AS project_count
FROM employees e
LEFT JOIN employee_projects ep
	ON e.emp_id = ep.employee_id
LEFT JOIN projects p
	ON ep.project_id = p.project_id
GROUP BY e.emp_id,e.emp_name
HAVING COUNT(p.project_id)>1;

-- Q7.
-- Generate a city-wise salary report.

-- Display:
-- - city
-- - employee_count
-- - average_salary
-- - total_salary
SELECT 
	city,
    COUNT(*) AS employee_count,
    AVG(salary)	AS average_salary,
    SUM(salary) AS total_salary
FROM employees
GROUP BY city;

-- Q8.
-- Find departments whose average salary
-- is greater than the company average.
SELECT 
	department_id,
    department,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department,department_id
HAVING AVG(salary) > (
	SELECT AVG(salary)
    FROM employees
);

-- Q9.
-- Generate a project report.

-- Display:
-- - project_name
-- - budget
-- - employee_count
-- - average_employee_salary
SELECT
    p.project_name,
    p.budget,
    COUNT(ep.employee_id) AS employee_count,
    AVG(e.salary) AS average_employee_salary
FROM projects p
LEFT JOIN employee_projects ep
    ON p.project_id = ep.project_id
LEFT JOIN employees e
    ON ep.employee_id = e.emp_id
GROUP BY
    p.project_id,
    p.project_name,
    p.budget;

-- Q10.
-- Generate an executive dashboard report.

-- Display:
-- - department_name
-- - employee_count
-- - average_salary
-- - total_salary
-- - project_count
-- - highest_salary

-- Sort by total_salary descending.

SELECT
    d.department_name,
    COUNT(DISTINCT e.emp_id) AS employee_count,
    AVG(e.salary) AS average_salary,
    SUM(e.salary) AS total_salary,
    COUNT(DISTINCT p.project_id) AS project_count,
    MAX(e.salary) AS highest_salary
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
LEFT JOIN employee_projects ep
    ON e.emp_id = ep.employee_id
LEFT JOIN projects p
    ON ep.project_id = p.project_id
GROUP BY d.department_id, d.department_name
ORDER BY total_salary DESC;