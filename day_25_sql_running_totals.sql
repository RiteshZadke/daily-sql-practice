-- Day 25 – SQL Running Totals

-- This file focuses on:
-- - Running Totals
-- - Cumulative Analysis
-- - Window Aggregations
-- - Trend Reporting
-- - Business Analytics


USE company_db;


-- Q1.
-- Display:
-- - employee_name
-- - salary
-- - running_total_salary

-- ordered by salary ascending.
SELECT 
	emp_name,
    salary,
    SUM(salary) OVER(ORDER BY salary ASC
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_salary
FROM employees;

-- Q2.
-- Display:
-- - employee_name
-- - salary
-- - cumulative_salary

-- ordered by salary descending.
SELECT 
	emp_name,
    salary,
    SUM(salary) OVER(ORDER BY salary DESC
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_salary
FROM employees;
    

-- Q3.
-- Display:
-- - project_name
-- - budget
-- - running_total_budget

-- ordered by budget ascending.
SELECT 
	project_name,
    budget,
    SUM(budget) OVER(ORDER BY budget ASC
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_budget
FROM projects;

-- Q4.
-- Display:
-- - employee_name
-- - department_id
-- - salary
-- - department_running_total

-- Calculate running salary total
-- within each department.
SELECT 
	emp_name,
    department_id,
    salary,
    SUM(salary) OVER(PARTITION BY department_id
		ORDER BY salary ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS department_running_total
FROM employees;

-- Q5.
-- Display:
-- - city
-- - employee_name
-- - salary
-- - city_running_total

-- Calculate running salary total
-- within each city.
SELECT
	city,
    emp_name,
    salary,
    SUM(salary) OVER(PARTITION BY city
		ORDER BY salary ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS city_running_total
	FROM employees;

-- Q6.
-- Display:
-- - project_name
-- - budget
-- - cumulative_budget_percentage

-- Calculate cumulative contribution
-- of budgets to total company budget.
SELECT
    project_name,
    budget,
    ROUND(
        (
            SUM(budget) OVER(
                ORDER BY budget DESC
                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) * 100.0
        ) /
        SUM(budget) OVER(),
        2
    ) AS cumulative_budget_percentage
FROM projects;
    

-- Q7.
-- Generate a department salary report.

-- Display:
-- - department_name
-- - salary
-- - running_department_salary
SELECT
	department,
    salary,
    SUM(salary) OVER(PARTITION BY department
		ORDER BY salary ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_department_salary
	FROM employees;

-- Q8.
-- Display:
-- - employee_name
-- - salary
-- - running_average_salary

-- using window functions.
SELECT
	emp_name,
    salary,
    AVG(salary) OVER(
		ORDER BY salary ASC
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_average_salary
FROM employees;

-- Q9.
-- Display:
-- - project_name
-- - budget
-- - running_average_budget

-- using window functions.
SELECT
	project_name,
    budget,
    AVG(budget) OVER(
		ORDER BY budget ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_average_budget
FROM projects;

-- Q10.
-- Generate an executive compensation report.

-- Display:
-- - employee_name
-- - department_name
-- - salary
-- - running_total_salary
-- - running_average_salary
-- - percentage_of_total_salary

-- Sort by salary descending.
SELECT
	emp_name,
    department,
    salary,
    SUM(salary) OVER(
		ORDER BY salary ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_total_salary,
	 AVG(salary) OVER(
		ORDER BY salary ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_average_salary,
	 ROUND(
        (
            SUM(salary) OVER(
                ORDER BY salary DESC
                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) * 100.0
        ) /
        SUM(salary) OVER(),
        2
		) AS percentage_of_total_salary
FROM employees;