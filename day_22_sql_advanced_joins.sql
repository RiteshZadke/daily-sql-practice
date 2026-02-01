-- Day 22 – SQL Phase 2 (Advanced Joins & Business Logic)
--
-- This file focuses on:
-- - Advanced join reasoning
-- - Translating business rules into SQL
-- - Handling edge cases and missing data
-- - Writing interview-grade, readable queries

USE daily_sql;

CREATE TABLE projects (
	project_id INT AUTO_INCREMENT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    department_name VARCHAR(100) NOT NULL
);

INSERT INTO projects (project_name,department_name) VALUES
('Customer Churn Analysis', 'Analytics'),
('Credit Risk Modeling', 'Data Science'),
('Employee Attrition Study', 'HR'),
('E-commerce Recommendation System', 'Data Science'),
('Sales Forecasting', 'Marketing'),
('Financial Fraud Detection', 'Finance'),
('Manufacturing Optimization', 'Engineering'),
('Marketing Campaign Analysis', 'Marketing'),
('Payroll Automation', 'HR'),
('Infrastructure Upgrade', 'Engineering'),
('Budget Planning Tool', 'Finance'),
('User Behavior Tracking', 'Analytics');

CREATE TABLE employee_projects (
	emp_id INT NOT NULL,
    project_id INT NOT NULL,
    PRIMARY KEY (emp_id, project_id),
    FOREIGN KEY (emp_id) REFERENCES employees (emp_id),
    FOREIGN KEY (project_id) REFERENCES projects (project_id)
);

SHOW TABLES;

-- Tables used:
-- employees, departments, projects, employee_projects

-- Q1. Orphan Records Detection
--     Find employees who are not assigned to any department.
--     Write the safest possible query.
SELECT e.* 
FROM employees e
LEFT JOIN departments d
	ON e.department_id = d.department_id
WHERE d.department_id IS NULL;

-- Q2. Reverse Orphan Logic
--     Find departments that currently have no employees.

SELECT d.*
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
WHERE e.emp_id IS NULL;

-- Q3. Cross-Table Business Rule
--     Find departments that have at least one project
--     but have zero employees.

SELECT d.*
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM projects p
    WHERE p.department_name = d.department_name
)
AND NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.department_id
);

-- Q4. EXISTS vs JOIN Judgment
--     Find employees who have worked on at least one project.
--     Solve using EXISTS.

SELECT e.*
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM employee_projects ep
    WHERE ep.emp_id = e.emp_id
);

-- Q5. Negative Logic (Project Assignment)
--     Find employees who have never worked on any project.
--     Solve using NOT EXISTS.

SELECT e.*
FROM employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM employee_projects ep
    WHERE ep.emp_id = e.emp_id
);


-- Q6. Department-Level Salary Comparison
--     Find employees who earn more than the average salary
--     of their department.

SELECT e.*
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);

-- Q7. Maximum per Department (Classic Trap)
--     Find the highest-paid employee(s) in each department.
--     Do NOT use window functions.

SELECT e.*
FROM employees e
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);

-- Q8. Cross-Department Consistency Check
--     Find employees who are assigned to projects
--     belonging to a DIFFERENT department than their own.

SELECT DISTINCT e.*
FROM employees e
JOIN employee_projects ep
    ON e.emp_id = ep.emp_id
JOIN projects p
    ON ep.project_id = p.project_id
WHERE e.department_id <> (
    SELECT d.department_id
    FROM departments d
    WHERE d.department_name = p.department_name
);

-- Q9. Universal Condition Logic
--     Find departments where ALL employees earn more than 50,000.

SELECT d.*
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.department_id
      AND e.salary <= 50000
);

-- Q10. SQL Design Reflection (comments only):
--      - One join mistake you now actively avoid
--      - One pattern you prefer for negative conditions
--      - One readability rule you will always follow

-- One join mistake I now actively avoid:
-- Using INNER JOIN when I actually need to detect missing data.

-- One pattern I prefer for negative conditions:
-- NOT EXISTS instead of NOT IN for NULL safety.

-- One readability rule I will always follow:
-- Express intent clearly (EXISTS / NOT EXISTS)
-- rather than forcing everything into JOINs.