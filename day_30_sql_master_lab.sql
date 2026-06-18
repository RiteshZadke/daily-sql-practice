-- Day 30 – SQL Master Lab

-- This file focuses on:
-- - JOINs
-- - Subqueries
-- - CTEs
-- - Window Functions
-- - Business Analytics
-- - Interview Preparation


USE company_db;


-- Q1.
-- Find the top 3 highest paid employees
-- in each department.
WITH top3_dep_emp AS (
	SELECT 
		emp_name,
        department_id,
        salary,
        ROW_NUMBER() OVER(
			PARTITION BY department_id
            ORDER BY salary DESC
        ) AS row_num
	FROM employees
)
SELECT 
	emp_name,
    department_id,
    salary
FROM top3_dep_emp
WHERE row_num <= 3;

-- Q2.
-- Find employees earning more than
-- their department average salary.
WITH emp_avg AS (
	SELECT 
		emp_name,
        department,
        salary,
        AVG(salary) OVER(
			PARTITION BY department
        ) AS department_avg
	FROM employees
)
SELECT
	emp_name,
    department,
    salary
FROM emp_avg 
WHERE salary > department_avg;

-- Q3.
-- Find departments having more employees
-- than the company average department size.
WITH dept_size AS (
    SELECT
        department_id,
        department,
        COUNT(*) AS employee_count
    FROM employees
    GROUP BY department_id, department
)

SELECT *
FROM (
    SELECT
        *,
        AVG(employee_count) OVER() AS company_avg_size
    FROM dept_size
) t
WHERE employee_count > company_avg_size;

-- Q4.
-- Find the employee assigned to the
-- maximum number of projects.
WITH max_proj AS(
	SELECT
		ep.employee_id,
		e.emp_name,
		COUNT(p.project_id) AS total_proj
	FROM employee_projects ep
	INNER JOIN employees e
		ON ep.employee_id = e.emp_id
	INNER JOIN projects p
		ON ep.project_id = p.project_id
	GROUP BY ep.employee_id ,e.emp_name
)
SELECT *
FROM max_proj
WHERE total_proj = (
	SELECT
		MAX(total_proj)
	FROM max_proj
);

-- Q5.
-- Generate a project leaderboard.

-- Display:
-- - project_name
-- - employee_count
-- - budget_rank
SELECT 
	p.project_name,
    COUNT(ep.employee_id) AS employee_count,
    RANK() OVER(
        ORDER BY p.budget DESC
	) AS budget_rank
    FROM projects p
    INNER JOIN employee_projects ep
		ON p.project_id = ep.project_id
	GROUP BY p.project_name,p.project_id,p.budget;
        

-- Q6.
-- Find projects whose budget is greater
-- than the average project budget.
SELECT
   project_name,
    budget
FROM projects
WHERE budget >
(
    SELECT AVG(budget)
    FROM projects
);
-- Q7.
-- Generate a department salary leaderboard.

-- Display:
-- - department_name
-- - employee_name
-- - salary
-- - rank
SELECT
    department AS department_name,
    emp_name AS employee_name,
    salary,

    RANK() OVER(
        PARTITION BY department
        ORDER BY salary DESC
    ) AS rank_position

FROM employees;

-- Q8.
-- Find employees who work on
-- more than one project.
WITH employee_projects_count AS (
    SELECT
        employee_id,
        COUNT(project_id) AS project_count
    FROM employee_projects
    GROUP BY employee_id
)

SELECT
    e.emp_name,
    epc.project_count
FROM employee_projects_count epc
INNER JOIN employees e
    ON epc.employee_id = e.emp_id
WHERE epc.project_count > 1;

-- Q9.
-- Generate a city performance report.

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
GROUP BY city
ORDER BY total_salary DESC;

-- Q10.
-- Generate an Executive Workforce Dashboard.

-- Display:
-- - department_name
-- - employee_count
-- - average_salary
-- - total_salary
-- - highest_salary
-- - project_count
-- - top_employee

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
),

top_employee AS (
    SELECT
        department,
        emp_name,
        salary,
        ROW_NUMBER() OVER(
            PARTITION BY department
            ORDER BY salary DESC
        ) AS rn
    FROM employees
)

SELECT
    ds.department AS department_name,
    ds.employee_count,
    ds.average_salary,
    ds.total_salary,
    ds.highest_salary,
    dp.project_count,
    te.emp_name AS top_employee

FROM dept_stats ds

LEFT JOIN dept_projects dp
    ON ds.department = dp.department

LEFT JOIN top_employee te
    ON ds.department = te.department
    AND te.rn = 1

ORDER BY ds.total_salary DESC;