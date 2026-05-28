-- Day 12 – SQL Subqueries

-- This file focuses on:
-- - Subqueries
-- - Nested SELECT statements
-- - Single-row subqueries
-- - Multi-row subqueries
-- - Relational filtering logic



USE company_db;


-- Tables Used:
--
-- employees
-- departments
-- projects
-- employee_projects


-- Q1.
-- Find employees whose salary is greater
-- than the average salary of all employees.
SELECT *
FROM employees
WHERE 
	salary > (
		SELECT AVG(salary)
        FROM employees
);

-- Q2.
-- Find employees working in the department
-- named 'IT' using a subquery.
SELECT *
FROM employees
WHERE department_id = (
    SELECT department_id
    FROM departments
    WHERE department_name = 'IT'
);

-- Q3.
-- Find employees who are assigned
-- to the project 'Cloud Migration'.
SELECT *
FROM employees
WHERE emp_id IN (
    SELECT ep.employee_id
    FROM employee_projects ep
    JOIN projects p
        ON ep.project_id = p.project_id
    WHERE p.project_name = 'Cloud Migration'
);

-- Q4.
-- Find the employee(s) earning
-- the highest salary in the company.
SELECT *
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
);

-- Q5.
-- Find employees whose experience is greater
-- than the average experience of their department.
SELECT *
FROM employees e
WHERE experince > (
	SELECT 
		AVG(experince)
	FROM employees
    WHERE department_id = e.department_id
);

-- Q6.
-- Find projects whose budget is greater
-- than the average project budget.
SELECT *
FROM projects
WHERE budget >(
	SELECT 
		AVG(budget)
	FROM projects
);

-- Q7.
-- Find departments having more employees
-- than the average employee count across departments.
SELECT
    department_id,
    COUNT(emp_id) AS total_employees
FROM employees
GROUP BY department_id
HAVING COUNT(emp_id) > (
    SELECT AVG(emp_count)
    FROM (
        SELECT COUNT(emp_id) AS emp_count
        FROM employees
        GROUP BY department_id
    ) AS dept_counts
);

-- Q8.
-- Find employees who are not assigned
-- to any project.
SELECT * 
FROM employees
WHERE emp_id NOT IN (
	SELECT employee_id
    FROM employee_projects
);

-- Q9.
-- Find projects that have at least
-- one employee earning more than 80000.
SELECT *
FROM projects
WHERE project_id IN (
	SELECT ep.project_id
    FROM employee_projects ep
    LEFT JOIN employees e
		ON e.emp_id = ep.employee_id
	WHERE e.salary > 80000
);

-- Q10.
-- Generate a high salary project report.

-- Display:
-- - project_name
-- - total_employees
-- - average_salary

-- Only include projects where:
-- average employee salary > company average salary.
SELECT
    p.project_name,
    COUNT(e.emp_id) AS total_employees,
    AVG(e.salary) AS average_salary
FROM projects p
LEFT JOIN employee_projects ep
    ON p.project_id = ep.project_id
LEFT JOIN employees e
    ON ep.employee_id = e.emp_id
GROUP BY p.project_id, p.project_name
HAVING AVG(e.salary) > (
    SELECT AVG(salary)
    FROM employees
);