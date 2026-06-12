-- Day 24 – SQL LEAD() & LAG()

-- This file focuses on:
-- - LEAD()
-- - LAG()
-- - Sequential analysis
-- - Comparative analytics
-- - Salary trend reporting


USE company_db;


-- Q1.
-- Display:
-- - employee_name
-- - salary
-- - previous_salary

-- using LAG().
SELECT
    emp_name,
    salary,
    LAG(salary) OVER(ORDER BY salary) AS previous_salary
FROM employees;

-- Q2.
-- Display:
-- - employee_name
-- - salary
-- - next_salary

-- using LEAD().
SELECT
    emp_name,
    salary,
    LEAD(salary) OVER(ORDER BY salary) AS next_salary
FROM employees;

-- Q3.
-- Display:
-- - employee_name
-- - salary
-- - salary_difference_from_previous

-- using LAG().
SELECT
    emp_name,
    salary,
    salary - LAG(salary) OVER(ORDER BY salary) AS salary_difference_from_previous
FROM employees;
    
-- Q4.
-- Display:
-- - employee_name
-- - salary
-- - salary_difference_from_next

-- using LEAD().
SELECT
    emp_name,
    salary,
    salary - LEAD(salary) OVER(ORDER BY salary) AS salary_difference_from_next
FROM employees;

-- Q5.
-- Display:
-- - employee_name
-- - department_id
-- - salary
-- - previous_department_salary

-- using LAG()
-- partitioned by department.
SELECT
    emp_name,
    department_id,
    salary,
    LAG(salary) OVER(
        PARTITION BY department_id
        ORDER BY salary
    ) AS previous_department_salary
FROM employees;

-- Q6.
-- Display:
-- - employee_name
-- - department_id
-- - salary
-- - next_department_salary

-- using LEAD()
-- partitioned by department.
SELECT
    emp_name,
    department_id,
    salary,
    LEAD(salary) OVER(
        PARTITION BY department_id
        ORDER BY salary
    ) AS next_department_salary
FROM employees;
	
-- Q7.
-- Display:
-- - project_name
-- - budget
-- - previous_budget

-- using LAG().
SELECT
    project_name,
    budget,
    LAG(budget) OVER(ORDER BY budget)
        AS previous_budget
FROM projects;

-- Q8.
-- Display:
-- - project_name
-- - budget
-- - next_budget

-- using LEAD().
SELECT
    project_name,
    budget,
    LEAD(budget) OVER(ORDER BY budget)
        AS next_budget
FROM projects;

-- Q9.
-- Generate a department salary movement report.

-- Display:
-- - department_name
-- - employee_name
-- - salary
-- - previous_salary
-- - salary_difference

-- Use LAG() partitioned by department.
SELECT
    department,
    emp_name,
    salary,
    LAG(salary) OVER(
        PARTITION BY department_id
        ORDER BY salary
    ) AS previous_salary,
    salary -
    LAG(salary) OVER(
        PARTITION BY department_id
        ORDER BY salary
    ) AS salary_difference
FROM employees;

-- Q10.
-- Generate a workforce comparison report.

-- Display:
-- - employee_name
-- - department_name
-- - salary
-- - previous_salary
-- - next_salary
-- - difference_from_previous
-- - difference_from_next

-- Sort by salary descending.

SELECT
    emp_name,
    department,
    salary,
    LAG(salary) OVER(
        ORDER BY salary DESC
    ) AS previous_salary,
    LEAD(salary) OVER(
        ORDER BY salary DESC
    ) AS next_salary,
    salary -
    LAG(salary) OVER(
        ORDER BY salary DESC
    ) AS difference_from_previous,
    salary -
    LEAD(salary) OVER(
        ORDER BY salary DESC
    ) AS difference_from_next
FROM employees

ORDER BY salary DESC;