-- Day 07 – SQL HAVING Clause

-- This file focuses on:
-- - HAVING clause
-- - Aggregate filtering
-- - Group-level conditions
-- - Business reporting
-- - Summary analysis


USE company_db;


-- Q1.
-- Display departments having more than 3 employees.
SELECT department
FROM employees
GROUP BY department
	HAVING COUNT(*) > 3;
    
-- Q2.
-- Display departments whose average salary
-- is greater than 60000.
SELECT department
FROM employees
GROUP BY department
	HAVING AVG(salary) > 60000;
    
-- Q3.
-- Display cities having more than 2 employees.
SELECT city
FROM employees
GROUP BY city 
	HAVING COUNT(*) > 2;

-- Q4.
-- Display cities whose average experience
-- is greater than 5 years.
SELECT cities
FROM employees
GROUP BY city
	HAVING AVG(ecperince) > 5;

-- Q5.
-- Display departments whose total salary
-- exceeds 200000.
SELECT department
FROM employees
GROUP BY department
	HAVING SUM(salary) > 200000;

-- Q6.
-- Display cities where the maximum salary
-- is greater than 80000.
 SELECT city
 FROM employees 
 GROUP BY city
	HAVING MAX(salary) > 80000; 

-- Q7.
-- Display departments having a minimum salary
-- greater than 40000.
 SELECT department
 FROM employees 
 GROUP BY department
	HAVING MIN(salary) > 40000; 


-- Q8.
-- Display cities where the average age
-- is less than 30 years.
SELECT city 
FROM employees
GROUP BY city
	HAVING AVG(age) < 30;

-- Q9.
-- Display departments having at least
-- 2 employees earning more than 50000.
SELECT department
FROM employees
WHERE salary > 50000
GROUP BY department
HAVING COUNT(*) >= 2;


-- Q10.
-- Display:
-- - department
-- - employee count
-- - average salary
-- - total salary

-- Only for departments where:
-- - average salary > 55000
-- AND
-- - employee count > 2

SELECT 
	department,
    COUNT(*) AS emp_count,
    AVG(salary) AS avg_sal,
    SUM(salary) AS total_sal
FROM employees
GROUP BY department
	HAVING AVG(salary) > 55000
		AND COUNT(*) > 2;