-- Day 13 – SQL Correlated Subqueries

-- This file focuses on:
-- - Correlated subqueries
-- - Row-by-row evaluation
-- - Department-level comparisons
-- - Advanced filtering logic
-- - Relational reasoning


USE company_db;


-- Q1.
-- Find employees whose salary is greater
-- than the average salary of their own department.
SELECT *
FROM employees e
WHERE salary > (
	SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);

-- Q2.
-- Find employees whose experience is greater
-- than the average experience of their department.
SELECT *
FROM employees e
WHERE experince > (
	SELECT AVG(experince)
    FROM employees
    WHERE department_id = e.department_id
);

-- Q3.
-- Find employees earning the highest salary
-- within their department.
SELECT *
FROM employees e
WHERE salary = (
	SELECT MAX(salary)
    FROM employees
    WHERE department_id = e.department_id
);

-- Q4.
-- Find employees earning the lowest salary
-- within their department.
SELECT *
FROM employees e
WHERE salary = (
	SELECT MIN(salary)
    FROM employees
    WHERE department_id = e.department_id
);

-- Q5.
-- Find departments where at least one employee
-- earns more than 90000.
SELECT 
	department_id,
    department
FROM employees e
WHERE emp_id IN (
	SELECT emp_id
    FROM employees
    WHERE department_id = e.department_id
		AND salary> 90000
);

-- Q6.
-- Find projects whose budget is greater than
-- the average budget of all projects assigned
-- to employees in the same department.
SELECT DISTINCT
    e.department_id,
    e.department
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e2.department_id = e.department_id
      AND e2.salary > 90000
);

-- Q7.
-- Find employees who are assigned to more projects
-- than the average employee.
SELECT
    e.emp_id,
    e.emp_name,
    COUNT(ep.project_id) AS project_count
FROM employees e
JOIN employee_projects ep
    ON e.emp_id = ep.employee_id
GROUP BY e.emp_id, e.emp_name
HAVING COUNT(ep.project_id) > (
    SELECT AVG(project_count)
    FROM (
        SELECT COUNT(project_id) AS project_count
        FROM employee_projects
        GROUP BY employee_id
    ) AS emp_projects
);

-- Q8.
-- Find departments whose average salary is higher
-- than the company average salary.
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

-- Q9.
-- Find projects that have at least one employee
-- earning more than the average company salary.
SELECT *
FROM projects
WHERE project_id IN (
    SELECT ep.project_id
    FROM employee_projects ep
    JOIN employees e
        ON ep.employee_id = e.emp_id
    WHERE e.salary > (
        SELECT AVG(salary)
        FROM employees
    )
);
    

-- Q10.
-- Generate a department performance report.

-- Display:
-- - department_name
-- - total_employees
-- - average_salary

-- Include only departments where:
-- average salary is greater than
-- the company average salary.

SELECT 
	department_id,
    department,
    COUNT(*) AS total_employees,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id,department
HAVING AVG(salary) >(
	SELECT AVG(salary)
    FROM employees
)