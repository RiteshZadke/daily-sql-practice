-- Day 17 – SQL CTE Basics

-- This file focuses on:
-- - Common Table Expressions (CTEs)
-- - Query decomposition
-- - Readability improvements
-- - Intermediate result sets
-- - Analytical SQL design


USE company_db;


-- Tables Used:
--
-- employees
-- departments
-- projects
-- employee_projects


-- Q1.
-- Create a CTE containing employees
-- earning more than 70000.

-- Display all columns.
WITH salary_cte	AS (
	SELECT *
    FROM employees
    WHERE salary > 70000
)
SELECT * FROM salary_cte;

-- Q2.
-- Create a CTE containing employees
-- from the IT department.

-- Display:
-- - employee_name
-- - salary
WITH emp_IT AS (
	SELECT 
		emp_name,
        salary
	FROM employees
    WHERE department = 'IT'
)
SELECT * 
FROM emp_IT;

-- Q3.
-- Create a CTE containing projects
-- whose budget exceeds 1000000.

-- Display all columns.
WITH high_budget AS (
	SELECT *
    FROM projects
    WHERE budget > 1000000
)
SELECT *
FROM high_budget;

-- Q4.
-- Create a CTE containing employees
-- with more than 5 years experience.

-- Display:
-- - employee_name
-- - department_id
-- - experience
WITH cte_experience AS(
	SELECT 
		emp_name,
        department_id,
        experince
	FROM employees
    WHERE experince > 5
)
SELECT *
FROM cte_experience;

-- Q5.
-- Create a CTE containing department-wise
-- employee counts.

-- Display:
-- - department_name
-- - employee_count
WITH cte_department AS (
	SELECT 
		department,
        COUNT(*) AS employee_count
	FROM employees
    GROUP BY department_id,department
)
SELECT *
FROM cte_department;

-- Q6.
-- Create a CTE containing project assignments.

-- Display:
-- - employee_name
-- - project_name
WITH project_assignments AS (
	SELECT 
		e.emp_name,
        p.project_name
	FROM employees e
    LEFT JOIN employee_projects ep
		ON e.emp_id = ep.employee_id
	INNER JOIN projects p
		ON ep.project_id = p.project_id
)
SELECT *
FROM project_assignments;

-- Q7.
-- Create a CTE containing employees whose
-- salary is greater than company average salary.
WITH high_salary AS (
	SELECT *
    FROM employees
    WHERE salary > (
		SELECT AVG(salary)
        FROM employees
    )
)
SELECT *
FROM high_salary;

-- Q8.
-- Create a CTE containing department-wise
-- average salaries.

-- Display departments having average salary
-- greater than 60000.
WITH department_avg_sal AS(
	SELECT 
    department_id,
    department
    FROM employees
    GROUP BY department_id,department
    HAVING AVG(salary) > 60000
)
SELECT * 
FROM department_avg_sal;

-- Q9.
-- Create a CTE containing project-wise
-- employee counts.

-- Display projects having more than
-- 2 employees assigned.
WITH project_employee_counts AS (
    SELECT
        p.project_id,
        p.project_name,
        COUNT(ep.employee_id) AS employee_count
    FROM projects p
    LEFT JOIN employee_projects ep
        ON p.project_id = ep.project_id
    GROUP BY p.project_id, p.project_name
)

SELECT *
FROM project_employee_counts
WHERE employee_count > 2;

-- Q10.
-- Generate a salary analysis report.

-- Using CTEs display:

-- - department_name
-- - employee_count
-- - average_salary
-- - maximum_salary

-- Sort by average_salary descending.
WITH department_salary_report AS (
    SELECT
        department,
        COUNT(emp_id) AS employee_count,
        AVG(salary) AS average_salary,
        MAX(salary) AS maximum_salary
    FROM employees
    GROUP BY department
)

SELECT *
FROM department_salary_report
ORDER BY average_salary DESC;