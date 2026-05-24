-- Day 08 – SQL CASE WHEN

-- This file focuses on:
-- - CASE WHEN
-- - Conditional classification
-- - Business rules
-- - Data categorization
-- - Derived columns

USE company_db;


-- Q1.
-- Display employee name and salary.
-- Create a column called salary_category.

-- Rules:
-- Salary >= 80000 -> High
-- Salary >= 50000 -> Medium
-- Otherwise -> Low
SELECT 
	emp_name,
    salary,
	CASE 
		WHEN salary >= 80000 THEN 'High'
        WHEN salary >= 50000 THEN 'Medium'
        ELSE 'Low'
	END AS salary_category
FROM employees;


-- Q2.
-- Display employee name and age.
-- Create an age_group column.

-- Rules:
-- Age < 25 -> Young
-- Age <= 35 -> Adult
-- Otherwise -> Senior
SELECT 
	emp_name,
    age,
    CASE
		WHEN age < 25 THEN 'Young'
        WHEN age <= 35 THEN 'Adult'
        ELSE  'Senior'
    END AS age_group
FROM employees;

-- Q3.
-- Display employee name and experience.
-- Create an experience_level column.

-- Rules:
-- Experience < 3 -> Beginner
-- Experience <= 7 -> Intermediate
-- Otherwise -> Expert
SELECT 
	emp_name,
    experince,
	CASE 
		WHEN experince < 3 THEN 'Beginner' 
        WHEN experince <=7 THEN 'Intermediate'
        ELSE 'Expert'
	END AS experience_level
FROM employees;

-- Q4.
-- Display employee name and city.
-- Create a location_type column.

-- Rules:
-- Mumbai -> Metro
-- Delhi -> Metro
-- Bangalore -> Metro
-- Otherwise -> Non-Metro
SELECT 
	emp_name,
    city,
    CASE 
		WHEN city IN ('Mumbai','Delhi','Bangalore') THEN 'Metro'
        ELSE 'Non-Metro'
	END AS location_type
    FROM employees;

-- Q5.
-- Display employee name and department.
-- Create a department_category column.

-- Rules:
-- IT, Finance -> Technical
-- HR, Marketing -> Business
-- Others -> Support
SELECT 
	emp_name,
    department,
    CASE 
		WHEN department IN ('IT','Finance') THEN 'Technical'
        WHEN department IN ('HR','Marketing') THEN 'Business'
        ELSE 'Support'
	END AS department_category
FROM employees;

-- Q6.
-- Display employee name, salary and bonus percentage.

-- Rules:
-- Salary >= 80000 -> 20%
-- Salary >= 50000 -> 10%
-- Otherwise -> 5%
SELECT 
	emp_name,
    salary,
    CASE 
		WHEN salary >= 80000 THEN '20%'
        WHEN salary >= 50000 THEN '10%'
        ELSE '5%'
	END AS bonus_percentage
FROM employees;

-- Q7.
-- Display employee name and salary.
-- Create a tax_rate column.

-- Rules:
-- Salary > 90000 -> 30%
-- Salary > 60000 -> 20%
-- Otherwise -> 10%
SELECT 
	emp_name,
    salary,
    CASE 
		WHEN salary >= 90000 THEN '30%'
        WHEN salary >= 60000 THEN '20%'
        ELSE '10%'
	END AS tax_rate
FROM employees;

-- Q8.
-- Display employee name and age.
-- Create a retirement_status column.

-- Rules:
-- Age >= 60 -> Retired
-- Otherwise -> Active
SELECT 
	emp_name,
    age,
    CASE 
		WHEN age >= 60 THEN 'Retired'
        ELSE 'Active'
	END AS retirement_status
FROM employees;

-- Q9.
-- Display employee name, salary and experience.
-- Create a promotion_eligibility column.

-- Rules:
-- Experience > 5 AND Salary < 70000
-- Eligible

-- Otherwise
-- Not Eligible
SELECT 
	emp_name,
    salary,
    experince,
    CASE
		WHEN experince > 5 AND salary < 70000 THEN 'Eligible'
		ELSE 'Not Eligible'
	END AS promotion_eligibility
    FROM employees;
    
-- Q10.
-- Display:
-- - employee_name
-- - department
-- - salary

-- Create two derived columns:

-- salary_band
-- performance_band

-- salary_band:
-- >= 80000 -> High
-- >= 50000 -> Medium
-- Otherwise -> Low

-- performance_band:
-- Experience >= 8 -> Excellent
-- Experience >= 5 -> Good
-- Otherwise -> Average


SELECT 
	emp_name,
    salary,
    experince,
	CASE 
		WHEN salary >= 80000 THEN 'High'
        WHEN salary >= 50000 THEN 'Medium'
        ELSE 'Low'
	END AS salary_band,
    CASE
		WHEN experince >= 8 THEN 'Excellent'
        WHEN experince >= 5 THEN 'Good'
        ELSE 'Average'
	END AS performance_band
FROM employees;