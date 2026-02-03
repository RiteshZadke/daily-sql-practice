-- Day 23 – SQL Phase 2 (Business Logic & Reporting Queries)
--
-- This file focuses on:
-- - Translating business rules into SQL
-- - Multi-step reasoning without engine tricks
-- - Choosing the safest construct
-- - Writing clean, review-ready queries
--
-- Tables used:
-- employees, departments, projects, employee_projects


USE daily_sql;


-- Q1. Active Department Definition
--     A department is considered "active" if:
--     - It has at least one employee
--     - AND at least one project
--     Find all active departments.

SELECT DISTINCT
    d.department_name
FROM departments d
INNER JOIN employees e
    ON e.department_id = d.department_id
INNER JOIN projects p
    ON p.department_name = d.department_name;

-- Q2. Project Staffing Check
--     Find projects that currently have NO employees assigned.
--     Explain why LEFT JOIN + IS NULL is appropriate here.

SELECT
    p.project_id
FROM projects p
LEFT JOIN employee_projects ep
    ON p.project_id = ep.project_id
WHERE ep.emp_id IS NULL;

-- Q3. High-Cost Departments
--     Find departments where the TOTAL salary cost
--     exceeds 200,000.

SELECT 
	department_id
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 200000;

-- Q4. Employee Contribution Report
--     For each employee, display:
--     - employee name
--     - number of projects assigned
--     Include employees with ZERO projects.
SELECT 
	e.name,
    COUNT(ep.project_id) AS project_assigned
FROM employees e
LEFT JOIN employee_projects ep
	ON e.emp_id = ep.emp_id
GROUP BY 
	e.emp_id,e.name;

-- Q5. Cross-Department Assignment Audit
--     Find employees who are assigned to projects
--     outside their own department.

SELECT DISTINCT
    e.emp_id,
    e.name
FROM employees e
INNER JOIN employee_projects ep
    ON e.emp_id = ep.emp_id
INNER JOIN projects p
    ON ep.project_id = p.project_id
WHERE e.department_id <> p.department_id;

-- Q6. Departments With Only One Project
--     Find departments that have exactly ONE project.

SELECT
    d.department_id
FROM departments d
LEFT JOIN projects p
    ON d.department_id = p.department_id
GROUP BY d.department_id
HAVING COUNT(p.project_id) = 1;

-- Q7. Salary Consistency Rule
--     Find departments where NO employee earns
--     less than 45,000.
SELECT
    d.department_id
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.department_id
      AND e.salary < 45000
);

-- Q8. Employees Without Project Exposure
--     Find employees who belong to departments
--     that have projects,
--     but the employee themselves is not assigned
--     to any project.

SELECT
    e.emp_id,
    e.name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM projects p
    WHERE p.department_id = e.department_id
)
AND NOT EXISTS (
    SELECT 1
    FROM employee_projects ep
    WHERE ep.emp_id = e.emp_id
);

-- Q9. Reporting-Ready Output
--     Produce a report showing:
--     - department name
--     - total employees
--     - total projects
--     Include departments even if one of the counts is zero.
SELECT
    d.department_name,
    COUNT(DISTINCT e.emp_id) AS total_employees,
    COUNT(DISTINCT p.project_id) AS total_projects
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
LEFT JOIN projects p
    ON d.department_id = p.department_id
GROUP BY d.department_name;

-- Q10. SQL Judgment Reflection (comments only):
--      - One reporting mistake you now consciously avoid
--      - One construct you trust most for business rules
--      - One readability habit you will enforce in SQL

-- Mistake I consciously avoid:
-- Using COUNT(*) with LEFT JOIN when checking existence

-- Construct I trust most for business rules:
-- NOT EXISTS (clearest intent, safest logic)

-- Readability habit I enforce:
-- One logical condition per line + explanatory comments
