-- Day 26 – SQL Moving Averages

-- This file focuses on:
-- - Moving Averages
-- - Rolling Analysis
-- - Window Frames
-- - Trend Detection
-- - Business Analytics


USE company_db;


-- Q1.
-- Display:
-- - employee_name
-- - salary
-- - moving_average_salary

-- Calculate a 3-row moving average
-- ordered by salary.
SELECT 
	emp_name,
    salary,
    AVG(salary) OVER(
		ORDER BY salary ASC
		ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
	) AS moving_average_salary
FROM employees;

-- Q2.
-- Display:
-- - project_name
-- - budget
-- - moving_average_budget

-- Calculate a 3-row moving average.
SELECT
	project_name,
    budget,
    AVG(budget) OVER(
		ORDER BY budget ASC
		ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
	) AS moving_average_budget
FROM projects;

-- Q3.
-- Display:
-- - employee_name
-- - department_id
-- - salary
-- - department_moving_average

-- Calculate moving average salary
-- within each department.
SELECT
	emp_name,
    department_id,
    salary,
    AVG(salary) OVER(
		PARTITION BY department_id 
        ORDER BY salary ASC
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
	) AS department_moving_average
FROM employees;

-- Q4.
-- Display:
-- - employee_name
-- - salary
-- - running_average_salary

-- ordered by salary ascending.
SELECT 
	emp_name,
    salary,
    AVG(salary) OVER(
		ORDER BY salary ASC 
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	) AS running_average_salary
FROM employees;

-- Q5.
-- Display:
-- - project_name
-- - budget
-- - running_average_budget

-- ordered by budget ascending.
SELECT
	project_name,
    budget,
    AVG(budget) OVER(
		ORDER BY budget ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	) AS running_average_budget
FROM projects;

-- Q6.
-- Display:
-- - city
-- - employee_name
-- - salary
-- - city_running_average

-- Calculate running average salary
-- within each city.
SELECT 
	city,
    emp_name,
    salary,
    AVG(salary) OVER (
		PARTITION BY city
        ORDER BY salary ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS city_running_average
FROM employees;

-- Q7.
-- Generate a department trend report.

-- Display:
-- - department_name
-- - employee_name
-- - salary
-- - department_average_salary
-- - moving_average_salary
SELECT
    department,
    emp_name,
    salary,

    AVG(salary) OVER(
        PARTITION BY department
    ) AS department_average_salary,

    AVG(salary) OVER(
        PARTITION BY department
        ORDER BY salary
        ROWS BETWEEN 2 PRECEDING
        AND CURRENT ROW
    ) AS moving_average_salary

FROM employees;

-- Q8.
-- Find employees whose salary is above
-- the moving average salary.
WITH salary_trend AS (
    SELECT
        emp_name,
        salary,
        AVG(salary) OVER(
            ORDER BY salary
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS moving_average_salary
    FROM employees
)

SELECT
    emp_name,
    salary,
    moving_average_salary
FROM salary_trend
WHERE salary > moving_average_salary;

-- Q9.
-- Find projects whose budget is above
-- the moving average project budget.
WITH moving_cte_budget AS (
    SELECT
        project_name,
        budget,

        AVG(budget) OVER(
            ORDER BY budget
            ROWS BETWEEN 2 PRECEDING
            AND CURRENT ROW
        ) AS moving_average_budget

    FROM projects
)

SELECT *
FROM moving_cte_budget
WHERE budget > moving_average_budget;


-- Q10.
-- Generate an executive compensation report.

-- Display:
-- - employee_name
-- - department_name
-- - salary
-- - running_average_salary
-- - moving_average_salary
-- - company_average_salary

-- Sort by salary descending.

SELECT
    emp_name AS employee_name,
    department AS department_name,
    salary,

    AVG(salary) OVER(
        ORDER BY salary DESC
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS running_average_salary,

    AVG(salary) OVER(
        ORDER BY salary DESC
        ROWS BETWEEN 2 PRECEDING
        AND CURRENT ROW
    ) AS moving_average_salary,

    AVG(salary) OVER()
        AS company_average_salary

FROM employees

ORDER BY salary DESC;