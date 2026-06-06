-- Day 21 – SQL Window Functions Introduction

-- This file focuses on:
-- - OVER()
-- - Window Functions
-- - Analytical Queries
-- - Ranking Concepts
-- - Department Analysis


USE company_db;


-- Q1.
-- Display:
-- - employee_name
-- - salary
-- - company average salary

-- using a window function.
SELECT 
	emp_name,
    salary,
    AVG(salary) OVER() AS company_average_salary
FROM employees;

-- Q2.
-- Display:
-- - employee_name
-- - department_id
-- - department average salary

-- using a window function.
SELECT 
	emp_name,
    department_id,
    AVG(salary) OVER(PARTITION BY department_id) AS department_average_salary
FROM employees;

-- Q3.
-- Display:
-- - employee_name
-- - salary
-- - highest salary in company

-- using a window function.
SELECT 
	emp_name,
    salary,
    MAX(salary) OVER() AS highest_salary_in_company
FROM employees;

-- Q4.
-- Display:
-- - employee_name
-- - salary
-- - lowest salary in company

-- using a window function.
SELECT 
	emp_name,
    salary,
    MIN(salary) OVER() AS highest_salary_in_company
FROM employees;

-- Q5.
-- Display:
-- - employee_name
-- - department_id
-- - highest department salary

-- using a window function.
SELECT 
	emp_name,
    department_id,
    MAX(salary) OVER(PARTITION BY department_id) AS highest_department_salary
FROM employees;

-- Q6.
-- Display:
-- - employee_name
-- - salary
-- - salary difference from company average.
SELECT
	emp_name,
    salary,
    salary - AVG(salary) OVER() AS salary_difference
FROM employees;

-- Q7.
-- Display:
-- - employee_name
-- - department_id
-- - salary
-- - department average salary
-- - difference from department average
SELECT 
	emp_name,
    department_id,
    salary,
    AVG(salary)	OVER(PARTITION BY department) department_average_salary,
    salary - AVG(salary)	OVER(PARTITION BY department) AS difference_from_department_average
FROM employees;

-- Q8.
-- Display:
-- - project_name
-- - budget
-- - average project budget

-- using a window function.
SELECT 
	project_name,
    budget,
    AVG(budget) OVER() AS average_project_budget
FROM projects;

-- Q9.
-- Display:
-- - department_name
-- - employee_count

-- along with total company employees
-- using a window function.
SELECT
    d.department_name,
    COUNT(e.emp_id) AS employee_count,
    SUM(COUNT(e.emp_id)) OVER() AS total_company_employees
FROM departments d
JOIN employees e
    ON d.department_id = e.department_id
GROUP BY d.department_name;
    

-- Q10.
-- Generate a workforce analytics report.

-- Display:
-- - employee_name
-- - department_name
-- - salary
-- - company_average_salary
-- - department_average_salary
-- - salary_difference

-- Sort by salary descending.

SELECT
    e.emp_name,
    d.department_name,
    e.salary,

    AVG(e.salary) OVER()
    AS company_average_salary,

    AVG(e.salary)
    OVER(PARTITION BY e.department_id)
    AS department_average_salary,

    e.salary -
    AVG(e.salary) OVER()
    AS salary_difference

FROM employees e
JOIN departments d
    ON e.department_id = d.department_id

ORDER BY e.salary DESC;