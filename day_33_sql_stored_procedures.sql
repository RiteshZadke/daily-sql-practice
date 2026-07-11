-- Day 33 – SQL Stored Procedures

-- This file focuses on:
-- - Stored Procedures
-- - Parameters
-- - Reusable SQL Logic
-- - Business Operations
-- - Database Programming
-- - Query Automation


USE company_db;


-- Q1. Create a stored procedure that
-- displays all employees.
CREATE PROCEDURE all_emp()
	SELECT *
    FROM employees;
CALL all_emp();

-- Q2. Create a stored procedure that
-- displays employees from a specific
-- department.
-- Pass department_id as parameter.
DELIMITER $$;
CREATE PROCEDURE department(IN dep_id INT)
	BEGIN
		SELECT * 
		FROM departments
		WHERE department_id = dep_id;
    END $$
DELIMITER ;
CALL department(2);

-- Q3. Create a stored procedure that
-- displays employees earning more than
-- a given salary.
-- Pass salary as parameter.
DELIMITER $$
CREATE PROCEDURE more_sal(IN p_salary INT)
	BEGIN
		SELECT *
        FROM employees
        WHERE salary > p_salary;
	END $$
DELIMITER ;
CALL more_sal(35000);

-- Q4. Create a stored procedure that
-- returns the total number of employees.
DELIMITER $$
CREATE PROCEDURE emp_count()
	BEGIN
		SELECT 
			COUNT(*) AS total_emp
		FROM employees;
	END $$
    DELIMITER ;
 CALL emp_count();
DELIMITER ;

-- Q5. Create a stored procedure that
-- returns:

-- - highest salary
-- - lowest salary
-- - average salary
DELIMITER $$
CREATE PROCEDURE aggregate_sal()
	BEGIN
		SELECT 
			MAX(salary) AS highest_salary,
            MIN(salary) AS lowest_salary,
            AVG(salary)	AS average_salary
		FROM employees;
	END $$
DELIMITER ;

-- Q6. Create a stored procedure that
-- inserts a new employee record.
-- Pass all required values
-- as parameters.
DELIMITER $$

CREATE PROCEDURE add_emp(
    IN p_emp_name VARCHAR(100),
    IN p_age INT,
    IN p_gender VARCHAR(10),
    IN p_department_id INT,
    IN p_salary DECIMAL(10,2),
    IN p_city VARCHAR(100),
    IN p_email VARCHAR(255)
)
BEGIN
    INSERT INTO employees (
        emp_name,
        age,
        gender,
        department_id,
        salary,
        city,
        email
    )
    VALUES (
        p_emp_name,
        p_age,
        p_gender,
        p_department_id,
        p_salary,
        p_city,
        p_email
    );
END $$

DELIMITER ;
CALL add_emp('Ritesh Zadke',22,'Male',2,50000,'Pune','ritesh11@email.com');
-- Q7. Create a stored procedure that
-- updates employee salary.
-- Pass:
-- - employee_id
-- - new_salary
DELIMITER $$

CREATE PROCEDURE update_salary(
    IN p_emp_id INT,
    IN p_new_salary DECIMAL(10,2)
)
BEGIN
    IF EXISTS (
        SELECT 1
        FROM employees
        WHERE emp_id = p_emp_id
    ) THEN

        UPDATE employees
        SET salary = p_new_salary
        WHERE emp_id = p_emp_id;

    ELSE
        SELECT 'Employee not found' AS message;
    END IF;
END $$

DELIMITER ;

-- Q8. Create a stored procedure that
-- deletes an employee record.

-- Pass employee_id as parameter.
DELIMITER $$
CREATE PROCEDURE delete_emp(p_emp_id INT)
	BEGIN 
		DELETE FROM employees
        WHERE emp_id = p_emp_id;
	END $$
DELIMITER ;

CALL delete_employee(5);

-- Q9. Create a stored procedure that
-- generates a department salary report.

-- Display:

-- - department_name
-- - employee_count
-- - average_salary
DELIMITER $$

CREATE PROCEDURE department_salary_report()
BEGIN
    SELECT
        d.department_name,
        COUNT(e.emp_id) AS employee_count,
        AVG(e.salary) AS average_salary
    FROM departments d
    LEFT JOIN employees e
        ON d.department_id = e.department_id
    GROUP BY
        d.department_id,
        d.department_name;
END $$

DELIMITER ;

CALL department_salary_report();


-- Q10. Build an Employee Analytics Procedure.

-- Generate:

-- - total employees
-- - average salary
-- - highest salary
-- - lowest salary
-- - department count

-- Display a complete summary report.

DELIMITER $$

CREATE PROCEDURE employee_analytics()
BEGIN
    SELECT
        COUNT(*) AS total_employees,
        AVG(salary) AS average_salary,
        MAX(salary) AS highest_salary,
        MIN(salary) AS lowest_salary,
        COUNT(DISTINCT department_id) AS department_count
    FROM employees;
END $$

DELIMITER ;

CALL employee_analytics();