-- Final Project: University Course Management System
-- Requires MySQL 8.0+
-- Safe to run repeatedly; existing databases/tables are not dropped.

CREATE DATABASE IF NOT EXISTS UniversityDB;
USE UniversityDB;

CREATE TABLE IF NOT EXISTS Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE,
    BirthDate DATE NOT NULL,
    EnrollmentDate DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(150) NOT NULL,
    DepartmentID INT NOT NULL,
    Credits INT NOT NULL,
    CONSTRAINT fk_courses_department
        FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Salary is included to satisfy the maximum instructor salary query.
CREATE TABLE IF NOT EXISTS Instructors (
    InstructorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE,
    DepartmentID INT NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL DEFAULT 0,
    CONSTRAINT fk_instructors_department
        FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATE NOT NULL,
    CONSTRAINT fk_enroll_student
        FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_enroll_course
        FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT uq_student_course UNIQUE (StudentID, CourseID)
);
