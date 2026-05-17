-- CREATE DATABASE company_db;
-- USE company_db;
-- CREATE TABLE employees(
-- emp_id INT PRIMARY KEY,
-- emp_name VARCHAR(100),
-- age INT,
-- gender VARCHAR(10),
-- department VARCHAR(50),
-- city VARCHAR(20),
-- salary DECIMAL(10,2),
-- experince INT
-- );

-- INSERT INTO employees VALUES
-- (101, 'Amit Sharma', 28, 'Male', 'IT', 'Mumbai', 60000, 4),
-- (102, 'Priya Verma', 32, 'Female', 'HR', 'Pune', 45000, 7),
-- (103, 'Rahul Patil', 26, 'Male', 'Finance', 'Mumbai', 52000, 3),
-- (104, 'Sneha Kulkarni', 29, 'Female', 'IT', 'Bangalore', 75000, 6),
-- (105, 'Arjun Mehta', 35, 'Male', 'Sales', 'Delhi', 48000, 10),
-- (106, 'Anjali Desai', 24, 'Female', 'Marketing', 'Mumbai', 39000, 2),
-- (107, 'Vikram Joshi', 31, 'Male', 'IT', 'Hyderabad', 82000, 8),
-- (108, 'Neha Singh', 27, 'Female', 'HR', 'Pune', 41000, 4),
-- (109, 'Akash Yadav', 30, 'Male', 'Finance', 'Chennai', 67000, 5),
-- (110, 'Pooja Nair', 25, 'Female', 'Marketing', 'Mumbai', 43000, 3),
-- (111, 'Ajay Kumar', 33, 'Male', 'Sales', 'Delhi', 58000, 9),
-- (112, 'Kiran Rao', 29, 'Female', 'IT', 'Bangalore', 91000, 7),
-- (113, 'Ayesha Shaikh', 23, 'Female', 'Support', 'Mumbai', 35000, 1),
-- (114, 'Rohan Das', 36, 'Male', 'Finance', 'Kolkata', 77000, 11),
-- (115, 'Meera Iyer', 28, 'Female', 'HR', 'Chennai', 47000, 5),
-- (116, 'Saurabh Jain', 27, 'Male', 'IT', 'Pune', 64000, 4),
-- (117, 'Divya Kapoor', 30, 'Female', 'Finance', 'Delhi', 72000, 6),
-- (118, 'Nikhil Shinde', 25, 'Male', 'Marketing', 'Mumbai', 41000, 2),
-- (119, 'Ritika Sen', 29, 'Female', 'HR', 'Kolkata', 50000, 5),
-- (120, 'Manoj Gupta', 34, 'Male', 'Sales', 'Hyderabad', 56000, 8),
-- (121, 'Komal Patil', 26, 'Female', 'Support', 'Pune', 36000, 3),
-- (122, 'Yash Thakur', 31, 'Male', 'IT', 'Bangalore', 87000, 7),
-- (123, 'Shreya Kulkarni', 24, 'Female', 'Marketing', 'Mumbai', 42000, 1),
-- (124, 'Harsh Vardhan', 38, 'Male', 'Finance', 'Delhi', 93000, 12),
-- (125, 'Tanvi Joshi', 28, 'Female', 'IT', 'Chennai', 69000, 5),
-- (126, 'Ritesh Pawar', 22, 'Male', 'Support', 'Solapur', 32000, 1),
-- (127, 'Sakshi More', 27, 'Female', 'HR', 'Mumbai', 46000, 4),
-- (128, 'Aditya Mishra', 33, 'Male', 'Sales', 'Lucknow', 61000, 9),
-- (129, 'Pallavi Sharma', 29, 'Female', 'Finance', 'Pune', 74000, 6),
-- (130, 'Kunal Naik', 26, 'Male', 'IT', 'Hyderabad', 81000, 4),
-- (131, 'Isha Chavan', 25, 'Female', 'Marketing', 'Bangalore', 44000, 2),
-- (132, 'Mohit Arora', 37, 'Male', 'Sales', 'Delhi', 67000, 11),
-- (133, 'Reema Shah', 31, 'Female', 'HR', 'Ahmedabad', 52000, 7),
-- (134, 'Tejas Patil', 28, 'Male', 'IT', 'Mumbai', 79000, 5),
-- (135, 'Naina Roy', 23, 'Female', 'Support', 'Kolkata', 34000, 1),
-- (136, 'Abhishek Singh', 35, 'Male', 'Finance', 'Chennai', 88000, 10),
-- (137, 'Madhuri Dixit', 30, 'Female', 'Marketing', 'Pune', 49000, 6),
-- (138, 'Sameer Khan', 27, 'Male', 'IT', 'Noida', 71000, 4),
-- (139, 'Bhavna Reddy', 32, 'Female', 'Sales', 'Hyderabad', 59000, 8),
-- (140, 'Deepak Yadav', 29, 'Male', 'Support', 'Mumbai', 37000, 3),
-- (141, 'Aniket Jadhav', 24, 'Male', 'IT', 'Solapur', 54000, 2),
-- (142, 'Priti Nair', 34, 'Female', 'Finance', 'Bangalore', 96000, 9),
-- (143, 'Ravi Verma', 28, 'Male', 'Marketing', 'Delhi', 45000, 5),
-- (144, 'Snehal Patwardhan', 26, 'Female', 'HR', 'Pune', 48000, 3),
-- (145, 'Farhan Ali', 39, 'Male', 'Sales', 'Mumbai', 99000, 14);

-- ============================================
-- Day 01 – SQL SELECT, WHERE
-- ============================================

-- This file contains 10 practice problems focused on:

-- - Basic SELECT queries
-- - WHERE clause filtering
-- - Comparison operators
-- - DISTINCT values
-- - Logical thinking with conditions


-- LAB RULES (READ FIRST)

-- - Each question is independent
-- - Focus on query readability
-- - Write clean SQL formatting
-- - Avoid unnecessary complexity
-- - Use proper indentation


USE company_db;


-- Q1.
-- Display all columns from the employees table.
SELECT * FROM employees;

-- Q2.
-- Display only:
-- - employee_id
-- - employee_name
-- - department
-- - salary
-- from the employees table.
SELECT 
	emp_id,
    emp_name,
    department,
    salary
    FROM employees;

-- Q3.
-- Display employees whose salary is greater than 50000.
SELECT * FROM employees 
	WHERE salary > 50000;

-- Q4.
-- Display employees who belong to the IT department.
SELECT * FROM employees 
	WHERE department = 'IT';

-- Q5.
-- Display employees whose age is less than 30.
SELECT * FROM employees 
WHERE age < 30;

-- Q6.
-- Display employees who live in Mumbai.
SELECT * FROM employees
WHERE city = 'Mumbai';

-- Q7.
-- Display employees whose salary is between 40000 and 80000.
SELECT * FROM employees
WHERE salary BETWEEN 40000 AND 80000;

-- Q8.
-- Display employees whose experience is greater than 5 years.
SELECT * FROM employees
WHERE experince > 5;

-- Q9.
-- Display all unique department names from the employees table.
SELECT DISTINCT department FROM employees;

-- Q10.
-- Display employees whose names start with the letter 'A'.
SELECT * 
FROM employees
WHERE emp_name LIKE 'A%';