-- ============================================
-- Day 04 – SQL LIKE, IN, BETWEEN
-- ============================================

-- This file contains 10 practice problems focused on:

-- - LIKE operator
-- - IN operator
-- - BETWEEN operator
-- - Pattern matching
-- - Multiple value filtering
-- - Range-based filtering



USE company_db;


-- Q1.
-- Display employees whose names start with the letter 'A'.
SELECT *
FROM employees
WHERE emp_name LIKE 'A%';

-- Q2.
-- Display employees whose names end with the letter 'a'.
SELECT *
FROM employees
WHERE emp_name LIKE "%a";

-- Q3.
-- Display employees whose names contain the word 'sh'.
SELECT *
FROM employees
WHERE emp_name LIKE '%sh%';

-- Q4.
-- Display employees whose salary is between 40000 and 70000.
SELECT * 
FROM employees
WHERE salary 
	BETWEEN 40000 AND 80000;

-- Q5.
-- Display employees whose age is between 25 and 30.
SELECT *
FROM employees
WHERE age 
	BETWEEN 25 AND 30;

-- Q6.
-- Display employees who belong to:
-- - Mumbai
-- - Pune
-- - Bangalore

-- using the IN operator.
SELECT *
FROM employees
WHERE city IN
	('Mumbai',"Pune",'Bangalore');

-- Q7.
-- Display employees whose department is either:
-- - IT
-- - HR
-- - Finance
SELECT *
FROM employees
WHERE department IN
	('IT','HR','Finance');

-- Q8.
-- Display employees whose experience is between 3 and 8 years.
SELECT *
FROM employees
WHERE experince 
	BETWEEN 3 AND 8;

-- Q9.
-- Display employees whose names have exactly 5 characters.
SELECT *
FROM employees
WHERE emp_name LIKE '_____';

-- Q10.
-- Display employees whose city name starts with the letter 'M'
-- AND salary is greater than 50000.
SELECT * 
FROM employees
WHERE city LIKE 'M%'
	AND salary > 50000;