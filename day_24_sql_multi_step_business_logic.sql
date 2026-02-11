-- Day 24 – SQL Phase 2 (Multi-Step Business Logic)
--
-- This file focuses on:
-- - Multi-layer reasoning
-- - Combining aggregation + filtering safely
-- - Business-rule enforcement in SQL
-- - Avoiding logical mistakes in reporting queries
--
-- Tables used:
-- employees, departments, projects, employee_projects


USE daily_sql;

-- Q1. Department Load Analysis
--     Find departments where:
--     - Total employees > 5
--     - AND total projects >= 2
--

SELECT 
    d.department_id
FROM departments d
JOIN (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING COUNT(*) > 5
) emp ON d.department_id = emp.department_id
JOIN (
    SELECT department_id
    FROM projects
    GROUP BY department_id
    HAVING COUNT(*) >= 2
) proj ON d.department_id = proj.department_id;

-- Q2. High-Impact Employees
--     Find employees who:
--     - Work on at least 2 projects
--     - AND earn more than their department’s average salary
--
SELECT e.emp_id, e.department_id, e.salary
FROM employees e
JOIN employee_projects ep 
    ON e.emp_id = ep.emp_id
GROUP BY e.emp_id, e.department_id, e.salary
HAVING 
    COUNT(DISTINCT ep.project_id) >= 2
    AND e.salary > (
        SELECT AVG(e2.salary)
        FROM employees e2
        WHERE e2.department_id = e.department_id
    );

-- Q3. Underutilized Projects
--     Find projects where:
--     - Assigned employees < 2
--     - But the department has more than 3 employees
SELECT p.project_id
FROM projects p
LEFT JOIN employee_projects ep 
    ON p.project_id = ep.project_id
GROUP BY p.project_id, p.department_id
HAVING 
    COUNT(DISTINCT ep.emp_id) < 2
    AND p.department_id IN (
        SELECT department_id
        FROM employees
        GROUP BY department_id
        HAVING COUNT(*) > 3
    );

-- Q4. Department Balance Rule
--     Find departments where:
--     - Maximum salary is at least 2×
--       the minimum salary within that department

SELECT department_id
FROM employees
GROUP BY department_id
HAVING MAX(salary) >= 2 * MIN(salary);



-- Q5. Isolated Employees
--     Find employees who:
--     - Belong to a department
--     - But none of their department colleagues
--       work on the same project as them

SELECT e.emp_id
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM employee_projects ep
    WHERE ep.emp_id = e.emp_id
)
AND NOT EXISTS (
    SELECT 1
    FROM employee_projects ep1
    JOIN employees e2 
        ON ep1.emp_id = e2.emp_id
    WHERE ep1.project_id IN (
        SELECT project_id
        FROM employee_projects
        WHERE emp_id = e.emp_id
    )
    AND e2.department_id = e.department_id
    AND e2.emp_id <> e.emp_id
);

-- Q6. Cross-Team Exposure Report
--     Find employees who have worked on
--     projects from more than one department.

SELECT ep.emp_id
FROM employee_projects ep
JOIN projects p 
    ON ep.project_id = p.project_id
GROUP BY ep.emp_id
HAVING COUNT(DISTINCT p.department_id) > 1;


-- Q7. Department Stability Check
--     Find departments where:
--     - The average salary is increasing
--       if you remove the highest-paid employee

SELECT department_id
FROM employees
GROUP BY department_id
HAVING 
    (SUM(salary) - MAX(salary)) / (COUNT(*) - 1) 
    > AVG(salary);


-- Q8. Employee Centrality Score
--     Find employees who:
--     - Work on the maximum number of projects
--       within their department

SELECT e.department_id, e.emp_id
FROM employees e
JOIN employee_projects ep 
    ON e.emp_id = ep.emp_id
GROUP BY e.department_id, e.emp_id
HAVING COUNT(DISTINCT ep.project_id) = (
    SELECT MAX(project_count)
    FROM (
        SELECT e2.department_id,
               e2.emp_id,
               COUNT(DISTINCT ep2.project_id) AS project_count
        FROM employees e2
        JOIN employee_projects ep2 
            ON e2.emp_id = ep2.emp_id
        WHERE e2.department_id = e.department_id
        GROUP BY e2.department_id, e2.emp_id
    ) sub
);


-- Q9. Reporting Integrity
--     Produce a report showing:
--     - department name
--     - total salary expense
--     - average salary
--     - total projects

SELECT 
    d.department_name,
    SUM(e.salary) AS total_salary,
    AVG(e.salary) AS avg_salary,
    COUNT(DISTINCT p.project_id) AS total_projects
FROM departments d
LEFT JOIN employees e 
    ON d.department_id = e.department_id
LEFT JOIN projects p 
    ON d.department_id = p.department_id
GROUP BY d.department_name;
