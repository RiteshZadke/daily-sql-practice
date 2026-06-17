-- Day 29 – SQL Database Design

-- This file focuses on:
-- - Database Design
-- - Primary Keys
-- - Foreign Keys
-- - Relationships
-- - Normalization
-- - Schema Modeling


USE company_db;


-- Q1. Design a Students table.

-- Include:
-- - student_id
-- - student_name
-- - email
-- - phone
-- - created_at

-- Apply appropriate constraints.
CREATE DATABASE school_db;

USE school_db;
CREATE TABLE students (
	student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(100)NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(10) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Q2. Design a Courses table.

-- Include:
-- - course_id
-- - course_name
-- - duration_months
-- - fees

-- Apply appropriate constraints.
CREATE TABLE courses (
	course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    duration_months INT NOT NULL
		CHECK(duration_months > 0),
    fees DECIMAL(10,2) NOT NULL
		CHECK(fees >= 0)
);

-- Q3. Design an Enrollments table.

-- Create relationships between:
-- - Students
-- - Courses

-- A student can enroll in multiple courses.
-- A course can have multiple students.
CREATE TABLE enrollments(
	enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    FOREIGN KEY (student_id)
		REFERENCES students(student_id),
	FOREIGN KEY (course_id)
		REFERENCES courses(course_id)
);

-- Q4. Design a Teachers table.

-- Include:
-- - teacher_id
-- - teacher_name
-- - specialization
-- - email
CREATE TABLE teachers (
	teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    teacher_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);

-- Q5. Design a Course_Assignments table.

-- Assign teachers to courses.

-- One teacher can teach multiple courses.
-- One course can have multiple teachers.
CREATE TABLE course_assignments (
	assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    teacher_id INT NOT NULL,
    course_id INT NOT NULL,
    FOREIGN KEY (teacher_id)
		REFERENCES teachers(teacher_id),
	FOREIGN KEY (course_id)
		REFERENCES courses(course_id)
);


-- Q6. Insert sample data into:

-- - Students
-- - Courses
-- - Teachers

-- Insert at least:
-- - 10 students
-- - 5 courses
-- - 5 teachers
INSERT INTO students
(student_name, email, phone)
VALUES
('Amit Sharma', 'amit@gmail.com', '9876543210'),
('Priya Verma', 'priya@gmail.com', '9876543211'),
('Rahul Patil', 'rahul@gmail.com', '9876543212'),
('Neha Singh', 'neha@gmail.com', '9876543213'),
('Karan Gupta', 'karan@gmail.com', '9876543214'),
('Sneha Joshi', 'sneha@gmail.com', '9876543215'),
('Rohit Kumar', 'rohit@gmail.com', '9876543216'),
('Anjali Mehta', 'anjali@gmail.com', '9876543217'),
('Vikas Yadav', 'vikas@gmail.com', '9876543218'),
('Pooja Desai', 'pooja@gmail.com', '9876543219');

INSERT INTO courses
(course_name, duration_months, fees)
VALUES
('Python Programming', 6, 15000.00),
('SQL for Data Analysis', 4, 12000.00),
('Machine Learning', 8, 30000.00),
('Power BI', 3, 10000.00),
('Data Structures', 5, 18000.00);

INSERT INTO teachers
(teacher_name, specialization, email)
VALUES
('Rajesh Kumar', 'Python', 'rajesh@academy.com'),
('Anita Sharma', 'SQL', 'anita@academy.com'),
('Vivek Patel', 'Machine Learning', 'vivek@academy.com'),
('Meena Joshi', 'Power BI', 'meena@academy.com'),
('Suresh Verma', 'Data Structures', 'suresh@academy.com');

-- Q7. Write queries to verify relationships.

-- Display:
-- - student_name
-- - course_name

-- for all enrollments.
SELECT 
	s.student_name,
    c.course_name
FROM enrollments e 
INNER JOIN students s
	ON e.student_id = s.student_id
INNER JOIN courses c
	ON e.course_id = c.course_id;

-- Q8. Generate a Student Enrollment Report.

-- Display:
-- - student_name
-- - course_name
-- - teacher_name
SELECT
    s.student_name,
    c.course_name,
    t.teacher_name
FROM enrollments e
INNER JOIN students s
    ON e.student_id = s.student_id
INNER JOIN courses c
    ON e.course_id = c.course_id
INNER JOIN course_assignments ca
    ON c.course_id = ca.course_id
INNER JOIN teachers t
    ON ca.teacher_id = t.teacher_id;

-- Q9. Generate a Course Analytics Report.

-- Display:
-- - course_name
-- - total_students
-- - fees
-- - total_revenue
SELECT
    c.course_name,
    COUNT(e.student_id) AS total_students,
    c.fees,
    COUNT(e.student_id) * c.fees AS total_revenue
FROM courses c
LEFT JOIN enrollments e
    ON c.course_id = e.course_id
GROUP BY
    c.course_id,
    c.course_name,
    c.fees
ORDER BY total_revenue DESC;

-- Q10. Generate an Executive Education Dashboard.

-- Display:
-- - total_students
-- - total_courses
-- - total_teachers
-- - total_revenue
-- - most_popular_course

SELECT
    (SELECT COUNT(*) FROM students) AS total_students,

    (SELECT COUNT(*) FROM courses) AS total_courses,

    (SELECT COUNT(*) FROM teachers) AS total_teachers,

    (
        SELECT SUM(c.fees)
        FROM enrollments e
        INNER JOIN courses c
            ON e.course_id = c.course_id
    ) AS total_revenue,

    (
        SELECT c.course_name
        FROM courses c
        LEFT JOIN enrollments e
            ON c.course_id = e.course_id
        GROUP BY c.course_id, c.course_name
        ORDER BY COUNT(e.student_id) DESC
        LIMIT 1
    ) AS most_popular_course;