-- ============================================
-- Day 03 – SQL Logical Operators
-- ============================================

-- This file contains 10 practice problems focused on:

-- - AND operator
-- - OR operator
-- - NOT operator
-- - Multiple filtering conditions
-- - Conditional query logic
-- - Query readability



USE company_db;


-- Q1.
-- Display employees whose salary is greater than 50000
-- AND department is IT.
SELECT *
FROM employees
WHERE salary > 50000 AND
	department = 'IT';

-- Q2.
-- Display employees who belong to Mumbai
-- OR Pune city.
SELECT *
FROM employees
WHERE city = 'Mumbai' OR
	city = 'Pune';

-- Q3.
-- Display employees whose age is greater than 25
-- AND experience is greater than 3 years.
SELECT * 
FROM employees
WHERE age > 25 AND
	experince > 3;

-- Q4.
-- Display employees who do NOT belong to the HR department.
SELECT * 
FROM employees
WHERE department != 'HR';

-- Q5.
-- Display employees whose salary is greater than 40000
-- AND less than 80000.
SELECT *
FROM employees
WHERE salary > 40000 AND
	salary < 80000;

-- Q6.
-- Display employees from the IT department
-- OR employees whose salary is greater than 90000.
SELECT *
FROM employees
WHERE department = 'IT' OR
	salary > 90000;

-- Q7.
-- Display employees whose experience is greater than 5
-- AND city is Mumbai.
SELECT *
FROM employees
WHERE experince>5 AND
	city = 'Mumbai';

-- Q8.
-- Display employees who are NOT from Delhi city.
SELECT *
FROM employees
WHERE city != 'Delhi';

-- Q9.
-- Display employees whose:
-- - department is Finance
-- AND
-- - salary is greater than 60000
-- AND
-- - experience is greater than 5 years.
SELECT *
FROM employees
WHERE (department = 'Finance' AND salary > 60000)
	AND experince > 5;

-- Q10.
-- Display employees who:
-- - belong to Sales department
-- OR
-- - belong to Marketing department
-- AND salary is greater than 45000.

SELECT *
FROM employees
WHERE department = 'sales' OR
	department = 'Marketing' AND
    salary > 45000;