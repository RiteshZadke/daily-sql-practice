-- Day 18 – SQL Advanced CTE Practice

-- This file focuses on:
-- - Multiple CTEs
-- - Chained CTEs
-- - Analytical reporting
-- - Query readability
-- - Business reporting


USE company_db;


-- Tables Used:
--
-- employees
-- departments
-- projects
-- employee_projects


-- Q1.
-- Create a CTE containing employees
-- earning above the company average salary.

-- Display:
-- - employee_name
-- - salary
WITH cte_salary AS(
	SELECT 
		emp_name,
        salary
	FROM employees
    WHERE salary > (
		SELECT AVG(salary)
        FROM employees
    )
)
SELECT *
FROM cte_salary;

-- Q2.
-- Create a CTE containing department-wise
-- average salaries.

-- Display departments whose average salary
-- is greater than the company average salary.
WITH department_salary AS(
	SELECT 
		department_id,
        department,
        AVG(salary) AS department_avg_sal
	FROM employees
    GROUP BY department,department_id
    HAVING AVG(salary) > (
		SELECT AVG(salary)
        FROM employees
    )
)
SELECT *
FROM department_salary;

-- Q3.
-- Create a CTE containing project-wise
-- employee counts.

-- Display projects having the highest
-- employee count.
WITH project_emp_count AS (
    SELECT
        p.project_name,
        COUNT(ep.employee_id) AS emp_count
    FROM projects p
    LEFT JOIN employee_projects ep
        ON p.project_id = ep.project_id
    GROUP BY p.project_id, p.project_name
)

SELECT *
FROM project_emp_count
WHERE emp_count = (
    SELECT MAX(emp_count)
    FROM project_emp_count
);


-- Q4.
-- Create two CTEs:

-- CTE 1:
-- department employee count

-- CTE 2:
-- department average salary

-- Combine both CTEs into one report.
WITH cte_1 AS (
	SELECT 
		department_id,
        department,
        COUNT(*) AS emp_count
	FROM employees
    GROUP BY department_id,department
),
 cte_2 AS(
	SELECT
		department_id,
        department,
        AVG(salary) AS avg_salary
	FROM employees
    GROUP BY department_id,department
)
SELECT
    cte_1.department_id,
    cte_1.department,
    cte_1.emp_count,
    cte_2.avg_salary
FROM cte_1
JOIN cte_2
	ON cte_1.department_id = cte_2.department_id;

-- Q5.
-- Create a CTE containing employees
-- assigned to more than one project.

-- Display:
-- - employee_name
-- - project_count
WITH emp_project AS (
    SELECT
        e.emp_name,
        COUNT(ep.project_id) AS project_count
    FROM employees e
    JOIN employee_projects ep
        ON e.emp_id = ep.employee_id
    GROUP BY e.emp_id, e.emp_name
)

SELECT *
FROM emp_project
WHERE project_count > 1;

-- Q6.
-- Create a CTE containing project budgets.

-- Categorize projects into:

-- High Budget
-- Medium Budget
-- Low Budget

-- based on budget values.
WITH project_budget AS (
    SELECT
        project_name,
        budget,
        CASE
            WHEN budget >= 1000000 THEN 'High Budget'
            WHEN budget >= 500000 THEN 'Medium Budget'
            ELSE 'Low Budget'
        END AS budget_category
    FROM projects
)

SELECT *
FROM project_budget;

-- Q7.
-- Create a CTE containing department-wise
-- maximum salary.

-- Display employees earning the maximum
-- salary within their department.
WITH dept_max_salary AS (
    SELECT
        department_id,
        MAX(salary) AS max_salary
    FROM employees
    GROUP BY department_id
)

SELECT
    e.emp_name,
    e.department,
    e.salary
FROM employees e
JOIN dept_max_salary dms
    ON e.department_id = dms.department_id
WHERE e.salary = dms.max_salary;

-- Q8.
-- Create a CTE containing employee-project
-- assignments.

-- Display employees working on projects
-- whose budget exceeds 1000000.
WITH emp_project_assignment AS (
    SELECT
        e.emp_name,
        p.project_name,
        p.budget
    FROM employees e
    JOIN employee_projects ep
        ON e.emp_id = ep.employee_id
    JOIN projects p
        ON ep.project_id = p.project_id
)

SELECT *
FROM emp_project_assignment
WHERE budget > 1000000;

-- Q9.
-- Create chained CTEs to generate
-- a department performance report.

-- Include:
-- - employee count
-- - average salary
-- - maximum salary
WITH employee_count AS (
    SELECT
        department_id,
        department,
        COUNT(*) AS employee_count
    FROM employees
    GROUP BY department_id, department
),

salary_stats AS (
    SELECT
        department_id,
        AVG(salary) AS average_salary,
        MAX(salary) AS maximum_salary
    FROM employees
    GROUP BY department_id
)

SELECT
    ec.department,
    ec.employee_count,
    ss.average_salary,
    ss.maximum_salary
FROM employee_count ec
JOIN salary_stats ss
    ON ec.department_id = ss.department_id;

-- Q10.
-- Generate an executive workforce report.

-- Display:
-- - department_name
-- - employee_count
-- - average_salary
-- - total_salary
-- - project_count

-- Sort by total_salary descending.
WITH department_stats AS (
    SELECT
        department_id,
        department,
        COUNT(*) AS employee_count,
        AVG(salary) AS average_salary,
        SUM(salary) AS total_salary
    FROM employees
    GROUP BY department_id, department
),

project_stats AS (
    SELECT
        e.department_id,
        COUNT(DISTINCT ep.project_id) AS project_count
    FROM employees e
    JOIN employee_projects ep
        ON e.emp_id = ep.employee_id
    GROUP BY e.department_id
)

SELECT
    ds.department,
    ds.employee_count,
    ds.average_salary,
    ds.total_salary,
    COALESCE(ps.project_count, 0) AS project_count
FROM department_stats ds
LEFT JOIN project_stats ps
    ON ds.department_id = ps.department_id
ORDER BY ds.total_salary DESC;