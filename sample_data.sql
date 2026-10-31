-- Run after schema.sql. All records are fictional.
USE UniversityDB;

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'Physics'),
(4, 'Business Administration'),
(5, 'Electronics');

INSERT INTO Students (StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate) VALUES
(1,  'John',    'Doe',      'john.doe@email.com',      '2000-01-15', '2022-08-01'),
(2,  'Jane',    'Smith',    'jane.smith@email.com',    '1999-05-25', '2021-08-01'),
(3,  'Michael', 'Brown',    'michael.brown@email.com', '2001-03-12', '2022-08-01'),
(4,  'Emily',   'Davis',    'emily.davis@email.com',   '2000-07-04', '2023-01-10'),
(5,  'David',   'Wilson',   'david.wilson@email.com',  '1998-11-30', '2020-08-01'),
(6,  'Sarah',   'Connor',   'sarah.connor@email.com',  '2002-02-14', '2023-08-01'),
(7,  'Robert',  'Chen',     'robert.chen@email.com',   '2001-09-19', '2022-08-01'),
(8,  'Linda',   'Park',     'linda.park@email.com',    '2000-12-05', '2024-01-15'),
(9,  'James',   'Miller',   'james.miller@email.com',  '1999-06-22', '2021-08-01'),
(10, 'Priya',   'Sharma',   'priya.sharma@email.com',  '2001-10-11', '2022-08-01'),
(11, 'Daniel',  'Garcia',   'daniel.garcia@email.com', '2000-04-28', '2023-08-01'),
(12, 'Sophia',  'Turner',   'sophia.turner@email.com', '2002-08-17', '2024-08-01');

INSERT INTO Courses (CourseID, CourseName, DepartmentID, Credits) VALUES
(101, 'Introduction to SQL',    1, 4),
(102, 'Data Structures',        1, 3),
(103, 'Discrete Mathematics',   2, 4),
(104, 'Linear Algebra',         2, 3),
(105, 'Calculus I',             2, 4),
(106, 'Calculus II',            2, 4),
(107, 'Probability Theory',     2, 3),
(108, 'Classical Mechanics',    3, 4),
(109, 'Digital Circuits',       5, 3),
(110, 'Marketing Fundamentals', 4, 2);

INSERT INTO Instructors (InstructorID, FirstName, LastName, Email, DepartmentID, Salary) VALUES
(1, 'Alice',  'Johnson',  'alice.johnson@univ.com',  1, 85000.00),
(2, 'Bob',    'Lee',      'bob.lee@univ.com',        2, 72000.00),
(3, 'Carol',  'Martinez', 'carol.martinez@univ.com', 1, 95000.00),
(4, 'David',  'Kim',      'david.kim@univ.com',      3, 68000.00),
(5, 'Emma',   'Wright',   'emma.wright@univ.com',    2, 78000.00),
(6, 'Frank',  'Patel',    'frank.patel@univ.com',    4, 60000.00),
(7, 'Grace',  'Nguyen',   'grace.nguyen@univ.com',   1, 88000.00);

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, EnrollmentDate) VALUES
(1,  1, 101, '2022-08-01'),
(2,  2, 102, '2021-08-01'),
(3,  3, 101, '2022-08-01'),
(4,  4, 101, '2023-01-10'),
(5,  5, 102, '2020-08-01'),
(6,  6, 103, '2023-08-01'),
(7,  7, 101, '2022-08-01'),
(8,  7, 102, '2022-08-01'),
(9,  8, 104, '2024-01-15'),
(10, 9, 105, '2021-08-01'),
(11, 10,101, '2022-08-01'),
(12, 10,102, '2022-08-01'),
(13, 11,106, '2023-08-01'),
(14, 12,107, '2024-08-01'),
(15, 1, 102, '2022-08-01'),
(16, 3, 102, '2022-08-01'),
(17, 4, 103, '2023-01-10'),
(18, 6, 101, '2023-08-01'),
(19, 8, 105, '2024-01-15'),
(20, 9, 106, '2021-08-01');
