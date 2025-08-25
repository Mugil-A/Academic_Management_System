-- Create Database
CREATE DATABASE AcademicManagement;
USE AcademicManagement;

-- Create StudentInfo Table
CREATE TABLE StudentInfo (
    STU_ID INT PRIMARY KEY AUTO_INCREMENT,
    STU_NAME VARCHAR(50) NOT NULL,
    DOB DATE,
    PHONE_NO VARCHAR(15),
    EMAIL_ID VARCHAR(50) UNIQUE,
    ADDRESS VARCHAR(100)
);

-- Create CoursesInfo Table
CREATE TABLE CoursesInfo (
    COURSE_ID INT PRIMARY KEY AUTO_INCREMENT,
    COURSE_NAME VARCHAR(50) NOT NULL,
    COURSE_INSTRUCTOR_NAME VARCHAR(50) NOT NULL
);

-- Create EnrollmentInfo Table
CREATE TABLE EnrollmentInfo (
    ENROLLMENT_ID INT PRIMARY KEY AUTO_INCREMENT,
    STU_ID INT,
    COURSE_ID INT,
    ENROLL_STATUS VARCHAR(20) CHECK (ENROLL_STATUS IN ('Enrolled','Not Enrolled')),
    FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
    FOREIGN KEY (COURSE_ID) REFERENCES CoursesInfo(COURSE_ID)
);


-- Insert Data into StudentInfo
INSERT INTO StudentInfo (STU_NAME, DOB, PHONE_NO, EMAIL_ID, ADDRESS) VALUES
('Mugilan', '2000-05-10', '9876543210', 'mugilan@gmail.com', 'Chennai'),
('Vinitha', '2001-08-15', '9876543211', 'vinitha@gmail.com', 'Madurai'),
('Yaksha', '2002-02-20', '9876543212', 'yaksha@gmail.com', 'Coimbatore'),
('Aarav', '2000-11-25', '9876543213', 'aarav@gmail.com', 'Chennai'),
('Jameer', '1999-03-14', '9876543214', 'jameer@gmail.com', 'Trichy'),
('Manoj', '2001-07-09', '9876543215', 'manoj@gmail.com', 'Salem'),
('Raja', '2002-12-22', '9876543216', 'raja@gmail.com', 'Erode'),
('Nikesh', '2000-06-30', '9876543217', 'nikesh@gmail.com', 'Chennai'),
('Venu', '1999-01-19', '9876543218', 'venu@gmail.com', 'Madurai'),
('Leo', '2001-09-05', '9876543219', 'leo@gmail.com', 'Chennai'),
('Aswin', '2002-04-27', '9876543220', 'aswin@gmail.com', 'Trichy'),
('Krishna', '2000-10-02', '9876543221', 'krishna@gmail.com', 'Chennai');

-- Insert Data into CoursesInfo
INSERT INTO CoursesInfo (COURSE_NAME, COURSE_INSTRUCTOR_NAME) VALUES
('Aero', 'Prabhu'),
('Mech', 'Mani'),
('Civil', 'Senthil');

-- Insert Data into EnrollmentInfo
INSERT INTO EnrollmentInfo (STU_ID, COURSE_ID, ENROLL_STATUS) VALUES
(1, 1, 'Enrolled'),
(2, 2, 'Enrolled'),
(3, 3, 'Enrolled'),
(4, 1, 'Not Enrolled'),
(5, 2, 'Enrolled'),
(6, 3, 'Not Enrolled'),
(7, 1, 'Enrolled'),
(8, 2, 'Enrolled'),
(9, 3, 'Not Enrolled'),
(10, 1, 'Enrolled'),
(11, 2, 'Enrolled'),
(12, 3, 'Enrolled');

-- Retrieve the Student Information
-- retrieve student details
SELECT 
    S.STU_NAME,
    S.PHONE_NO,
    S.EMAIL_ID,
    E.ENROLL_STATUS
FROM StudentInfo S
JOIN EnrollmentInfo E ON S.STU_ID = E.STU_ID;

-- Student and Course
SELECT 
    S.STU_NAME,
    C.COURSE_NAME
FROM StudentInfo S
JOIN EnrollmentInfo E ON S.STU_ID = E.STU_ID
JOIN CoursesInfo C ON E.COURSE_ID = C.COURSE_ID
WHERE E.ENROLL_STATUS = 'Enrolled';

-- Course and Instructor
SELECT 
    COURSE_NAME,
    COURSE_INSTRUCTOR_NAME
FROM CoursesInfo;

-- Course Info
SELECT 
    COURSE_NAME,
    COURSE_INSTRUCTOR_NAME
FROM CoursesInfo
WHERE COURSE_NAME = 'Aero';

-- Multiple Course
SELECT 
    COURSE_NAME,
    COURSE_INSTRUCTOR_NAME
FROM CoursesInfo
WHERE COURSE_NAME IN ('Aero', 'Mech');

-- 4. Reporting and Analytics (Using joining queries)

-- No. of students in Each course
SELECT 
    C.COURSE_NAME,
    COUNT(E.STU_ID) AS Total_Students
FROM CoursesInfo C
JOIN EnrollmentInfo E ON C.COURSE_ID = E.COURSE_ID
WHERE E.ENROLL_STATUS = 'Enrolled'
GROUP BY C.COURSE_NAME;

-- List of students in specific course
SELECT 
    S.STU_NAME,
    C.COURSE_NAME
FROM StudentInfo S
JOIN EnrollmentInfo E ON S.STU_ID = E.STU_ID
JOIN CoursesInfo C ON E.COURSE_ID = C.COURSE_ID
WHERE E.ENROLL_STATUS = 'Enrolled'
  AND C.COURSE_NAME = 'Aero';
  
-- Count of students for instructor
SELECT 
    C.COURSE_INSTRUCTOR_NAME,
    COUNT(E.STU_ID) AS Total_Enrolled_Students
FROM CoursesInfo C
JOIN EnrollmentInfo E ON C.COURSE_ID = E.COURSE_ID
WHERE E.ENROLL_STATUS = 'Enrolled'
GROUP BY C.COURSE_INSTRUCTOR_NAME;

-- Multiple course student list
SELECT 
    S.STU_NAME,
    COUNT(E.COURSE_ID) AS Number_of_Courses
FROM StudentInfo S
JOIN EnrollmentInfo E ON S.STU_ID = E.STU_ID
WHERE E.ENROLL_STATUS = 'Enrolled'
GROUP BY S.STU_NAME
HAVING COUNT(E.COURSE_ID) > 1;

-- High to Low
SELECT 
    C.COURSE_NAME,
    COUNT(E.STU_ID) AS Total_Enrolled_Students
FROM CoursesInfo C
JOIN EnrollmentInfo E ON C.COURSE_ID = E.COURSE_ID
WHERE E.ENROLL_STATUS = 'Enrolled'
GROUP BY C.COURSE_NAME
ORDER BY Total_Enrolled_Students DESC;





