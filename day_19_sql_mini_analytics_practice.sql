-- Day 19 – SQL Mini Analytics Practice

-- This file focuses on:
-- - Business reporting
-- - Aggregations
-- - JOINs
-- - Subqueries
-- - CTEs
-- - Analytical thinking


USE company_db;


-- Q1.
-- Generate a department salary report.

-- Display:
-- - department_name
-- - employee_count
-- - average_salary
-- - total_salary
SELECT 
	d.department_name,
    COUNT(e.emp_id) AS employee_count,
    AVG(e.salary) AS average_salary,
    SUM(e.salary) AS total_salary
FROM employees e
LEFT JOIN departments d 
	ON e.department_id = d.department_id
GROUP BY d.department_id,d.department_name;

-- Q2.
-- Find the top 5 highest paid employees
-- in the company.
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 5;

-- Q3.
-- Find departments whose average salary
-- is greater than the company average salary.
SELECT
    department_id,
    department,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id, department
HAVING AVG(salary) > (
    SELECT AVG(salary)
    FROM employees
);

-- Q4.
-- Find projects having more than
-- 2 employees assigned.
SELECT 
	p.project_id,
    p.project_name,
    COUNT(ep.employee_id) AS assigned_emp
FROM employee_projects ep
INNER JOIN projects p 
	ON ep.project_id = p.project_id
GROUP BY p.project_id,p.project_name
HAVING COUNT(ep.employee_id) > 2;

-- Q5.
-- Display project-wise employee counts.
SELECT 
	p.project_id,
    p.project_name,
    COUNT(ep.employee_id) AS assigned_emp
FROM employee_projects ep
INNER JOIN projects p 
	ON ep.project_id = p.project_id
GROUP BY p.project_id,p.project_name;

-- Q6.
-- Find employees working on projects
-- with budgets greater than 1000000.
WITH budget AS (
	SELECT e.*
    FROM employees e
    INNER JOIN employee_projects ep
		ON e.emp_id = ep.employee_id
	LEFT JOIN projects p
		ON ep.project_id = p.project_id
	WHERE p.budget > 1000000
)
SELECT *
FROM budget;

-- Q7.
-- Generate a city-wise employee report.

-- Display:
-- - city
-- - employee_count
-- - average_salary

SELECT 
	city,
	COUNT(*) AS employee_count,
	AVG(salary) AS average_salary
FROM employees
GROUP BY city;

-- Q8.
-- Find employees assigned to
-- multiple projects.
WITH employee_project_counts AS (
    SELECT
        e.emp_id,
        e.emp_name,
        COUNT(p.project_id) AS project_count
    FROM employees e
    LEFT JOIN employee_projects ep
        ON e.emp_id = ep.employee_id
    LEFT JOIN projects p
        ON ep.project_id = p.project_id
    GROUP BY e.emp_id, e.emp_name
)

SELECT *
FROM employee_project_counts
WHERE project_count > 1;

-- Q9.
-- Generate a project budget report.

-- Display:
-- - project_name
-- - budget
-- - employee_count
SELECT
    p.project_name,
    p.budget,
    COUNT(ep.employee_id) AS employee_count
FROM projects p
LEFT JOIN employee_projects ep
    ON p.project_id = ep.project_id
GROUP BY p.project_id, p.project_name, p.budget;

-- Q10.
-- Generate an executive company report.

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
    COUNT(DISTINCT ep.project_id) AS project_count,
    MAX(e.salary) AS highest_salary
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
LEFT JOIN employee_projects ep
    ON e.emp_id = ep.employee_id
GROUP BY d.department_id, d.department_name
ORDER BY total_salary DESC;