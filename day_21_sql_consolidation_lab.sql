-- Day 21 – Core SQL Consolidation Lab (Judgment & Design)
--
-- This file focuses on:
-- - Revisiting core SQL patterns
-- - Fixing common logical mistakes
-- - Choosing the safest construct
-- - Writing readable, interview-ready SQL
--
-- Tables used: employees, departments


USE daily_sql;

-- LAB RULES:
-- - Each question is independent
-- - Prefer clarity over cleverness
-- - Add comments explaining WHY a construct is chosen
-- - No new syntax, no window functions, no CASE WHEN


-- Q1. JOIN Sanity Check
--     Display employee name and department name.
--     Write the cleanest INNER JOIN possible.
--     Explain in comments why this is better than a subquery here.
SELECT 
	e.name,
	d.department_name
FROM employees e
INNER JOIN departments d
	ON e.department_id = d.department_id;

-- INNER JOIN is the cleanest choice because:
-- We only want employees who actually belong to a department.
-- INNER JOIN naturally enforces this by returning rows
-- only when a matching department exists.

-- This is better than a subquery because:
-- A subquery would first look up the department separately
-- for each employee, which is harder to read and reason about.
-- JOINs express relationships directly and clearly.
-- Optimizers handle JOINs very efficiently in relational databases.
-- The intent ("combine employees with their departments") is obvious.

-- Q2. LEFT JOIN Trap Fix
--     Find departments that have no employees.
--     First, write a WRONG version (LEFT JOIN + WHERE mistake).
--     Then write the CORRECT version.
--     Explain the difference in comments.

-- WRONG VERSION
SELECT 
	e.department_id,
    d.department_name
FROM employees e
LEFT JOIN departments d
	ON e.department_id = d.department_id
WHERE d.department_name IS NULL;
-- This query starts from the employees table.
-- LEFT JOIN keeps all employees, even if they have no matching department.
-- The WHERE clause filters rows where department_name is NULL.
-- This means we are finding employees who do NOT belong to any department.
-- It does NOT answer the question.

-- CORRECT VERSION
SELECT 
    d.department_id,
    d.department_name
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
WHERE e.department_id IS NULL;
-- This query starts from the departments table.
-- LEFT JOIN keeps all departments, even if they have no matching employees.
-- For departments with no employees, all columns from employees become NULL.
-- The WHERE clause checks e.department_id IS NULL to detect this absence.
-- This correctly finds departments that have zero employees.


-- Q3. EXISTS vs IN Judgment
--     Find departments that have at least one employee
--     earning more than 80,000.
--     Solve using EXISTS.
--     Explain why EXISTS is clearer than IN here.
SELECT DISTINCT
    e.department_id,
    e.department
FROM employees e
WHERE EXISTS (
	SELECT 1
    FROM employees e2
    WHERE e.department_id = e2.department_id
      AND e2.salary > 80000
);
-- EXISTS is clearer than IN here because:
-- The requirement is to check whether at least one qualifying employee exists.
-- EXISTS directly expresses presence / absence logic.
-- IN implies comparing a value against a returned list, which is less intuitive.
-- EXISTS avoids NULL-related issues that can affect IN.
-- EXISTS can stop scanning as soon as one matching row is found.

-- Q4. Negative Logic (Safer Pattern)
--     Find employees who do not belong to any department.
--     Solve using NOT EXISTS.
--     Explain why NOT EXISTS is safer than NOT IN.
SELECT *
FROM employees e
WHERE NOT EXISTS (
	SELECT 1
    FROM departments d
    WHERE d.department_id = e.department_id
);

-- NOT EXISTS is safer than NOT IN because:
-- NOT EXISTS checks row-by-row absence using a correlated condition.
-- It is NOT affected by NULL values in the subquery result.
-- NOT IN can return no rows if the subquery contains even one NULL.
-- NOT EXISTS expresses negative existence logic clearly and predictably.
-- This makes NOT EXISTS the safer and preferred pattern for anti-joins.

-- Q5. Aggregate Placement Check
--     Find departments whose average salary is greater than 60,000.
--     Explain in comments why the condition belongs in HAVING,
--     not WHERE.
SELECT 
    department
FROM employees
GROUP BY department
HAVING AVG(salary) > 60000;

-- The condition belongs in HAVING because:
-- WHERE filters rows BEFORE grouping happens.
-- AVG(salary) is an aggregate value that exists only AFTER GROUP BY.
-- WHERE cannot reference aggregate functions.
-- HAVING filters groups based on aggregate results.
-- Using HAVING here correctly applies the condition at the group level.

-- Q6. Correlated Subquery Reasoning
--     Find employees who earn more than the average salary
--     of their department.
--     Explain in comments how correlation works row by row.
SELECT 
e.*
FROM employees e
WHERE e.salary > (
	SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e.department = e2.department
);

-- This is a correlated subquery because:
-- The inner subquery references a column from the outer query (e.department).
-- For each row in the outer query (each employee),
-- the subquery recalculates the average salary of THAT employee's department.
-- The comparison is done row by row, not once for the whole table.
-- Only employees whose salary is greater than their department's average are returned.
-- Correlation ties each inner query execution to the current outer row.


-- Q7. Maximum per Group (No Window Functions)
--     Find employees who earn the maximum salary
--     in their respective department.
--     Explain why this query is conceptually tricky.
SELECT * 
FROM employees e
WHERE e.salary = (
	SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e.department_id = e2.department_id
);
-- This query is conceptually tricky because:
-- The maximum salary must be computed separately for EACH department.
-- The subquery is correlated, so it runs once per outer row.
-- We are comparing a single employee's salary to a department-level aggregate.
-- Multiple employees can share the same maximum salary in a department.
-- This makes the result potentially return multiple rows per department.
-- Without window functions, correlation is required to align row-level
-- data with group-level calculations.

-- Q8. NULL Safety Drill
--     Find employees whose salary is NOT NULL
--     and greater than 50,000.
--     Explain in comments why explicit NULL checks matter.
SELECT *
FROM employees
WHERE salary IS NOT NULL
  AND salary > 50000;

-- Explicit NULL checks matter because:
-- Comparisons with NULL do not behave like normal comparisons.
-- Any condition like salary > 50000 evaluates to UNKNOWN if salary is NULL.
-- Relying on implicit behavior can silently exclude or mis-handle rows.
-- Writing IS NOT NULL makes the intent clear and the logic predictable.
-- It improves readability and prevents bugs when data contains missing values.


-- Q9. Over-Engineering Detection
--     Take ANY ONE query above and:
--     - write an over-complicated version
--     - write a simpler, clearer version
--     Explain why the simpler version is preferred.

-- Over-complicated version
SELECT *
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e.employee_id = e2.employee_id
      AND e2.salary IS NOT NULL
      AND e2.salary > 50000
);

-- Simpler, clearer version

SELECT *
FROM employees
WHERE salary IS NOT NULL
  AND salary > 50000;

-- The simpler version is preferred because:
-- It expresses the condition directly without unnecessary indirection.
-- No correlation or subquery is needed for a row-level check.
-- EXISTS adds cognitive load without adding correctness.
-- Fewer moving parts makes the query easier to read, debug, and maintain.
-- Clear intent is more valuable than clever construction.


-- Q10. SQL Consolidation Reflection (comments only):
--      - One SQL mistake you now catch immediately
--      - One construct you deliberately choose more often
--      - One habit you will follow in future SQL writing

-- One SQL mistake I now catch immediately:
-- Using the wrong starting table, which changes the question
-- and silently produces logically incorrect results.

-- One construct I deliberately choose more often:
-- EXISTS / NOT EXISTS for presence or absence checks,
-- because they are clear, NULL-safe, and express intent directly.

-- One habit I will follow in future SQL writing:
-- Always align the query’s row level (employee vs department)
-- with what the question is actually asking before writing SQL.
