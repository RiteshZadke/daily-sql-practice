-- Day 28 – SQL Business Analytics Queries

-- This file focuses on:
-- - Business Analytics
-- - Executive Reporting
-- - Window Functions
-- - Performance Analysis
-- - Decision Support Queries


USE company_db;


-- Q1.
-- Generate a department performance report.

-- Display:
-- - department_name
-- - employee_count
-- - average_salary
-- - total_salary

-- Sort by total_salary descending.
WITH department_cte AS (
	SELECT 
		department,
		COUNT(*) AS employee_count,
		AVG(salary) AS average_salary,
		SUM(salary) AS total_salary
	FROM employees
	GROUP BY department,department_id
)
SELECT *
FROM department_cte
ORDER BY total_salary DESC;

-- Q2.
-- Find the top 5 highest paid employees
-- in the company.
WITH top_5 AS (
	SELECT
		emp_name,
		salary,
		DENSE_RANK() OVER(ORDER BY salary DESC) AS emp_rank
	FROM employees
)
SELECT 
	emp_name,
    salary
FROM top_5
WHERE emp_rank <= 5;
    
-- Q3.
-- Find the top earning employee
-- from each department.
WITH top_earner AS (
	SELECT
		emp_name,
        department_id,
		salary,
		DENSE_RANK() OVER(
			PARTITION BY department_id
            ORDER BY salary DESC
		) AS emp_rank
	FROM employees
)
SELECT 
	emp_name,
    department_id,
    salary
FROM top_earner
WHERE emp_rank = 1;

-- Q4.
-- Generate a city-wise workforce report.

-- Display:
-- - city
-- - employee_count
-- - average_salary
-- - total_salary
SELECT 
	city,
    COUNT(*) AS employee_count,
    AVG(salary) AS average_salary,
    SUM(salary) AS total_salary
FROM employees
GROUP BY city;

-- Q5.
-- Find projects with the highest budgets.

-- Display:
-- - project_name
-- - budget
-- - budget_rank
SELECT
	project_name,
    budget,
    RANK() OVER(ORDER BY budget DESC) AS budget_rank
FROM projects;

-- Q6.
-- Generate a project staffing report.

-- Display:
-- - project_name
-- - employee_count
-- - average_salary
SELECT 
	p.project_name,
    COUNT(ep.employee_id) AS employee_count,
    AVG(e.salary) AS average_salary
FROM employees e
INNER JOIN employee_projects ep
	ON e.emp_id = ep.employee_id
LEFT JOIN projects p
	ON ep.project_id = p.project_id
GROUP BY p.project_name,p.project_id;

-- Q7.
-- Find employees earning more than
-- their department average salary.
WITH dept_salary AS (
    SELECT
        emp_name,
        department,
        salary,
        AVG(salary) OVER(
            PARTITION BY department_id
        ) AS department_average_salary
    FROM employees
)

SELECT
    emp_name,
    department,
    salary
FROM dept_salary
WHERE salary > department_average_salary;

-- Q8.
-- Generate a department salary leaderboard.

-- Display:
-- - department_name
-- - employee_name
-- - salary
-- - department_rank
SELECT
	department,
    emp_name,
    salary,
    RANK() OVER(
		PARTITION BY department 
        ORDER BY salary DESC
	) AS department_rank
FROM employees;

-- Q9.
-- Generate an employee contribution report.

-- Display:
-- - employee_name
-- - project_count
-- - salary
-- - salary_rank
SELECT
    e.emp_name,
    COUNT(ep.project_id) AS project_count,
    e.salary,
    RANK() OVER(
        ORDER BY e.salary DESC
    ) AS salary_rank
FROM employees e
LEFT JOIN employee_projects ep
    ON e.emp_id = ep.employee_id
GROUP BY
    e.emp_id,
    e.emp_name,
    e.salary;

-- Q10.
-- Generate an executive workforce dashboard.

-- Display:
-- - department_name
-- - employee_count
-- - average_salary
-- - total_salary
-- - highest_salary
-- - project_count

-- Sort by total_salary descending.
WITH dept_stats AS (
    SELECT
        department,
        COUNT(*) AS employee_count,
        AVG(salary) AS average_salary,
        SUM(salary) AS total_salary,
        MAX(salary) AS highest_salary
    FROM employees
    GROUP BY department
),
dept_projects AS (
    SELECT
        e.department,
        COUNT(DISTINCT ep.project_id) AS project_count
    FROM employees e
    LEFT JOIN employee_projects ep
        ON e.emp_id = ep.employee_id
    GROUP BY e.department
)

SELECT
    ds.department AS department_name,
    ds.employee_count,
    ds.average_salary,
    ds.total_salary,
    ds.highest_salary,
    dp.project_count
FROM dept_stats ds
LEFT JOIN dept_projects dp
    ON ds.department = dp.department
ORDER BY ds.total_salary DESC;