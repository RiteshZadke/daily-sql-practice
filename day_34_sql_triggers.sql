-- Day 34 – SQL Triggers

-- This file focuses on:
-- - Triggers
-- - BEFORE Trigger
-- - AFTER Trigger
-- - Automatic Logging
-- - Data Validation
-- - Event Handling


USE company_db;


-- Q1.
-- Create an audit_logs table.

-- Store:

-- - log_id
-- - action_type
-- - employee_id
-- - action_time
CREATE TABLE audit_logs(
	log_id INT AUTO_INCREMENT PRIMARY KEY,
    action_type VARCHAR(20) NOT NULL,
    employee_id INT,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id)
		REFERENCES employees(emp_id)
);


-- Q2.
-- Create an AFTER INSERT trigger.

-- Automatically insert a record
-- into audit_logs whenever
-- a new employee is added.
DELIMITER $$
CREATE TRIGGER trg_after_employee_insert
AFTER INSERT 
ON employees
FOR EACH ROW
BEGIN 
	INSERT INTO audit_logs(
		action_type,
        employee_id
    )
    VALUES(
		'INSERT',
        NEW.emp_id
    );
END $$
DELIMITER ;

INSERT INTO employees (
	emp_id,
    emp_name,
    age,
    gender,
    department_id,
    salary,
    city
)
VALUES (
	100,
    'Rahul Sharma',
    28,
    'Male',
    2,
    65000,
    'Mumbai'
);
SELECT *
FROM audit_logs;

-- Q3.
-- Create an AFTER UPDATE trigger.

-- Log employee salary updates
-- into audit_logs.
DELIMITER $$
CREATE TRIGGER trg_after_employee_update
AFTER UPDATE 
ON employees
FOR EACH ROW
BEGIN 
	INSERT INTO audit_logs(
		action_type,
        employee_id
    )
    VALUES(
		'UPDATE',
        NEW.emp_id
    );
END $$
DELIMITER ;

UPDATE employees
SET salary = 85000
WHERE emp_id = 102;

SELECT * FROM audit_logs;

-- Q4.
-- Create an AFTER DELETE trigger.

-- Log deleted employee records
-- into audit_logs.

DELIMITER $$
CREATE TRIGGER trg_after_employee_delete1
BEFORE DELETE
ON employees
FOR EACH ROW
BEGIN
	INSERT INTO audit_logs(
		action_type,
		employee_id
    )
    VALUES(
		'DELETE',
        OLD.emp_id
    );
END $$
DELIMITER ;

DELETE FROM employees
WHERE emp_id = 100;

-- Q5.
-- Create a BEFORE INSERT trigger.

-- Prevent insertion of employees
-- having negative salary.
DELIMITER $$
CREATE TRIGGER trg_before_employee_insert
BEFORE insert
ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be negative';
    END IF;
END $$
DELIMITER ;

INSERT INTO employees
(emp_id,emp_name, age, gender, department_id, salary, city)
VALUES
(1001,'Rahul', 28, 'Male', 2, 50000, 'Mumbai');

INSERT INTO employees
(emp_name, age, gender, department_id, salary, city)
VALUES
('Amit', 30, 'Male', 1, -5000, 'Pune');

-- Q6.
-- Create a BEFORE UPDATE trigger.

-- Prevent salary from being
-- updated to a negative value.
DELIMITER $$
CREATE TRIGGER trg_before_employee_update
BEFORE UPDATE 
ON employees
FOR EACH ROW
BEGIN
	IF NEW.salary < 0 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be negative';
	END IF;
END $$
DELIMITER ;

UPDATE employees
SET salary = -4500
WHERE emp_id = 2;

-- Q7.
-- Test all triggers by:

-- - inserting records
-- - updating records
-- - deleting records

-- Verify audit_logs.
INSERT INTO employees
(emp_name, age, gender, department_id, salary, city)
VALUES
('Rahul Sharma', 28, 'Male', 2, 65000, 'Mumbai');

UPDATE employees
SET salary = 75000
WHERE emp_name = 'Rahul Sharma';

DELETE FROM employees
WHERE emp_name = 'Rahul Sharma';

SELECT *
FROM audit_logs;

-- Q8.
-- Display all records from
-- audit_logs.

-- Sort by latest action.
SELECT
    log_id,
    action_type,
    employee_id,
    action_time
FROM audit_logs
ORDER BY action_time DESC;

-- Q9.
-- Modify an existing trigger.

-- Add logging for the
-- employee_name field.
ALTER TABLE audit_logs
ADD COLUMN employee_name VARCHAR(100);

DROP TRIGGER IF EXISTS trg_after_employee_insert;

DROP TRIGGER IF EXISTS trg_after_employee_update;

DROP TRIGGER IF EXISTS trg_after_employee_delete;

DELIMITER $$

CREATE TRIGGER trg_after_employee_insert
AFTER INSERT
ON employees
FOR EACH ROW
BEGIN
    INSERT INTO audit_logs
    (
        action_type,
        employee_id,
        employee_name
    )
    VALUES
    (
        'INSERT',
        NEW.emp_id,
        NEW.emp_name
    );
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_after_employee_update
AFTER UPDATE
ON employees
FOR EACH ROW
BEGIN
    INSERT INTO audit_logs
    (
        action_type,
        employee_id,
        employee_name
    )
    VALUES
    (
        'UPDATE',
        NEW.emp_id,
        NEW.emp_name
    );
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_after_employee_delete
AFTER DELETE
ON employees
FOR EACH ROW
BEGIN
    INSERT INTO audit_logs
    (
        action_type,
        employee_id,
        employee_name
    )
    VALUES
    (
        'DELETE',
        OLD.emp_id,
        OLD.emp_name
    );
END $$

DELIMITER ;

-- Q10.
-- Build an Employee Audit System.

-- Automatically record:

-- - INSERT
-- - UPDATE
-- - DELETE

-- Display a complete
-- employee activity history.

CREATE TABLE audit_logs
(
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    action_type VARCHAR(20) NOT NULL,
    employee_id INT,
    employee_name VARCHAR(100),
    action_time TIMESTAMP
    DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER trg_after_employee_insert
AFTER INSERT
ON employees
FOR EACH ROW
BEGIN
    INSERT INTO audit_logs
    (
        action_type,
        employee_id,
        employee_name
    )
    VALUES
    (
        'INSERT',
        NEW.emp_id,
        NEW.emp_name
    );
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_after_employee_update
AFTER UPDATE
ON employees
FOR EACH ROW
BEGIN
    INSERT INTO audit_logs
    (
        action_type,
        employee_id,
        employee_name
    )
    VALUES
    (
        'UPDATE',
        NEW.emp_id,
        NEW.emp_name
    );
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_after_employee_delete
AFTER DELETE
ON employees
FOR EACH ROW
BEGIN
    INSERT INTO audit_logs
    (
        action_type,
        employee_id,
        employee_name
    )
    VALUES
    (
        'DELETE',
        OLD.emp_id,
        OLD.emp_name
    );
END $$

DELIMITER ;

SELECT
    log_id,
    employee_id,
    employee_name,
    action_type,
    action_time
FROM audit_logs
ORDER BY action_time DESC;