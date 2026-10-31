-- Run after sample_data.sql. These create/update examples are intentionally
-- run once; IDs 13, 111, 8, and 6 follow the supplied sample data.
USE UniversityDB;

-- CREATE: add one additional row to each table.
INSERT INTO Students (StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate)
VALUES (13, 'Nina', 'Patel', 'nina.patel@email.com', '2002-05-20', '2024-08-01');

INSERT INTO Courses (CourseID, CourseName, DepartmentID, Credits)
VALUES (111, 'Operating Systems', 1, 4);

INSERT INTO Instructors (InstructorID, FirstName, LastName, Email, DepartmentID, Salary)
VALUES (8, 'Henry', 'Ford', 'henry.ford@univ.com', 3, 66000.00);

-- Sarah is already in the sample data. Enrolling her in the new course
-- demonstrates an INSERT while keeping Nina available for the LEFT JOIN example.
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, EnrollmentDate)
VALUES (21, 6, 111, '2024-08-01');

INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES (6, 'Chemistry');

-- READ: inspect every table.
SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Instructors;
SELECT * FROM Enrollments;
SELECT * FROM Departments;

-- UPDATE: one example per table.
UPDATE Students
SET Email = 'john.doe@university.edu'
WHERE StudentID = 1;

UPDATE Courses
SET Credits = 5
WHERE CourseID = 101;

UPDATE Instructors
SET Salary = 90000.00
WHERE InstructorID = 1;

UPDATE Enrollments
SET EnrollmentDate = '2022-08-15'
WHERE EnrollmentID = 1;

UPDATE Departments
SET DepartmentName = 'Computer Science & Engineering'
WHERE DepartmentID = 1;

-- DELETE: uncomment these individually to demonstrate deletion.
-- Delete child rows before deleting related parent rows.
-- DELETE FROM Enrollments WHERE EnrollmentID = 21;
-- DELETE FROM Students WHERE StudentID = 13;
-- DELETE FROM Instructors WHERE InstructorID = 4;
-- DELETE FROM Courses WHERE CourseID = 111;
-- DELETE FROM Departments WHERE DepartmentID = 5;
