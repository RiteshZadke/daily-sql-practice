-- Day 32 – SQL Indexes

-- This file focuses on:
-- - Indexes
-- - Query Performance
-- - Single Column Indexes
-- - Composite Indexes
-- - Unique Indexes
-- - Query Optimization


USE company_db;


-- Q1. Create an index on employee_name.

-- Create an index named:
-- idx_employee_name

-- Verify that the index exists.
CREATE INDEX idx_employee_name
ON employees(emp_name);
SHOW INDEXES
FROM employees;
SELECT *
FROM employees
WHERE emp_name = 'Rahul';

-- Q2. Create an index on salary.

-- After creating the index:

-- Find employees earning
-- more than 70000.
CREATE INDEX idx_salary
ON employees(emp_name);
SELECT *
FROM employees
WHERE salary > 70000;

-- Q3. Create an index on city.

-- Write queries to find:

-- - employees from Mumbai
-- - employees from Pune
-- - employees from Bangalore
CREATE INDEX idx_city
ON employees(city);
SELECT *
FROM employees
WHERE city in ('Mumbai','Pune','Bangalore');

-- Q4. Create a composite index.

-- Columns:

-- - department_id
-- - salary

-- Write a query that finds:

-- employees from a specific department
-- earning more than a specific salary.
CREATE INDEX idx_dept_salary
ON employees(department_id, salary);

SELECT
    emp_name,
    department_id,
    salary
FROM employees
WHERE department_id = 2
AND salary > 70000;

SHOW INDEXES
FROM employees;

-- Q5. Create a UNIQUE index on email.

-- Test the index by:

-- - inserting a valid email
-- - attempting to insert a duplicate email

-- Observe the result.
CREATE UNIQUE INDEX idx_email
ON employees(email);

INSERT INTO employees
(emp_name, email, department_id, salary)
VALUES
('Rohit', 'rohit@gmail.com', 1, 65000);

INSERT INTO employees
(emp_name, email, department_id, salary)
VALUES
('Amit', 'rohit@gmail.com', 2, 70000);

-- Q6. Display all indexes
-- created on employees table.

-- Show:

-- - index name
-- - column name
-- - index type
SHOW INDEXES
FROM employees;

SELECT
    INDEX_NAME,
    COLUMN_NAME,
    INDEX_TYPE
FROM information_schema.statistics
WHERE table_schema = 'company_db'
AND table_name = 'employees';


-- Q7. Drop an index.

-- Remove:

-- idx_city

-- Verify that the index
-- has been removed successfully.
DROP INDEX idx_city
ON employees;

SHOW INDEXES
FROM employees;

-- Q8. Create an index on project_name
-- in the projects table.

-- Search for:

-- - a specific project
-- - projects containing a keyword
CREATE INDEX idx_project_name
ON projects(project_name);

SELECT *
FROM projects
WHERE project_name = 'AI Project';

SELECT *
FROM projects
WHERE project_name LIKE '%AI%';

-- Q9. Analyze query execution.

-- Use EXPLAIN for:

-- Query 1:
-- Search employee by employee_name

-- Query 2:
-- Search employee by salary

-- Observe which index
-- is being used.
EXPLAIN
SELECT *
FROM employees
WHERE emp_name = 'Rahul';

EXPLAIN
SELECT *
FROM employees
WHERE salary = 70000;

CREATE INDEX idx_salary
ON employees(salary);

-- Q10. Build an Index Optimization Report.

-- Create indexes for:

-- - employee_name
-- - department_id
-- - salary
-- - city

-- Write queries that use each index.

-- Document:

-- - index name
-- - column indexed
-- - query executed
-- - expected performance benefit

CREATE INDEX idx_employee_name
ON employees(emp_name);

CREATE INDEX idx_department_id
ON employees(department_id);

CREATE INDEX idx_salary
ON employees(salary);

CREATE INDEX idx_city
ON employees(city);


SELECT *
FROM employees
WHERE emp_name = 'Rahul';

SELECT *
FROM employees
WHERE department_id = 2;

SELECT *
FROM employees
WHERE salary > 70000;

SELECT *
FROM employees
WHERE city = 'Mumbai';