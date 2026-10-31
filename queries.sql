-- University Course Management System: required query examples.
-- Run after schema.sql, sample_data.sql, and (for all example rows)
-- crud_operations.sql. MySQL 8.0+ is required for the window function.
USE UniversityDB;

-- Q2. Students enrolled after 2022.
SELECT StudentID, CONCAT(FirstName, ' ', LastName) AS FullName,
       Email, EnrollmentDate
FROM Students
WHERE EnrollmentDate > '2022-12-31'
ORDER BY EnrollmentDate;

-- Q3. Mathematics courses, sorted and limited to five.
SELECT c.CourseID, c.CourseName, d.DepartmentName, c.Credits
FROM Courses AS c
JOIN Departments AS d ON d.DepartmentID = c.DepartmentID
WHERE d.DepartmentName = 'Mathematics'
ORDER BY c.CourseID
LIMIT 5;

-- Q4. Courses with more than five enrolled students.
SELECT c.CourseID, c.CourseName, COUNT(e.StudentID) AS StudentCount
FROM Courses AS c
LEFT JOIN Enrollments AS e ON e.CourseID = c.CourseID
GROUP BY c.CourseID, c.CourseName
HAVING COUNT(e.StudentID) > 5
ORDER BY StudentCount DESC;

-- Variant: enrollment count for every course, including empty courses.
SELECT c.CourseID, c.CourseName, COUNT(e.StudentID) AS StudentCount
FROM Courses AS c
LEFT JOIN Enrollments AS e ON e.CourseID = c.CourseID
GROUP BY c.CourseID, c.CourseName
ORDER BY StudentCount DESC, c.CourseID;

-- Q5. Students enrolled in both Introduction to SQL and Data Structures.
SELECT s.StudentID, CONCAT(s.FirstName, ' ', s.LastName) AS FullName, s.Email
FROM Students AS s
JOIN Enrollments AS e ON e.StudentID = s.StudentID
JOIN Courses AS c ON c.CourseID = e.CourseID
WHERE c.CourseName IN ('Introduction to SQL', 'Data Structures')
GROUP BY s.StudentID, s.FirstName, s.LastName, s.Email
HAVING COUNT(DISTINCT c.CourseName) = 2
ORDER BY s.StudentID;

-- Q6. Students enrolled in either course.
SELECT DISTINCT s.StudentID, CONCAT(s.FirstName, ' ', s.LastName) AS FullName, s.Email
FROM Students AS s
JOIN Enrollments AS e ON e.StudentID = s.StudentID
JOIN Courses AS c ON c.CourseID = e.CourseID
WHERE c.CourseName IN ('Introduction to SQL', 'Data Structures')
ORDER BY s.StudentID;

-- Q7. Average credits per course.
SELECT ROUND(AVG(Credits), 2) AS AverageCredits
FROM Courses;

-- Bonus: average credits by department.
SELECT d.DepartmentName, ROUND(AVG(c.Credits), 2) AS AvgCredits
FROM Courses AS c
JOIN Departments AS d ON d.DepartmentID = c.DepartmentID
GROUP BY d.DepartmentID, d.DepartmentName
ORDER BY AvgCredits DESC;

-- Q8. Maximum instructor salary in Computer Science.
-- Run after crud_operations.sql updates the department name.
SELECT MAX(i.Salary) AS MaxInstructorSalary
FROM Instructors AS i
JOIN Departments AS d ON d.DepartmentID = i.DepartmentID
WHERE d.DepartmentName = 'Computer Science & Engineering';

-- Bonus: identify the instructor(s) earning the maximum in that department.
SELECT i.InstructorID, CONCAT(i.FirstName, ' ', i.LastName) AS InstructorName,
       i.Salary, d.DepartmentName
FROM Instructors AS i
JOIN Departments AS d ON d.DepartmentID = i.DepartmentID
WHERE d.DepartmentName = 'Computer Science & Engineering'
  AND i.Salary = (
      SELECT MAX(i2.Salary)
      FROM Instructors AS i2
      JOIN Departments AS d2 ON d2.DepartmentID = i2.DepartmentID
      WHERE d2.DepartmentName = 'Computer Science & Engineering'
  );

-- Q9. Unique students enrolled in courses in each department.
SELECT d.DepartmentID, d.DepartmentName,
       COUNT(DISTINCT e.StudentID) AS StudentCount
FROM Departments AS d
LEFT JOIN Courses AS c ON c.DepartmentID = d.DepartmentID
LEFT JOIN Enrollments AS e ON e.CourseID = c.CourseID
GROUP BY d.DepartmentID, d.DepartmentName
ORDER BY StudentCount DESC, d.DepartmentID;

-- Q10. INNER JOIN: students with their enrolled courses.
SELECT s.StudentID, CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
       c.CourseID, c.CourseName, e.EnrollmentDate
FROM Students AS s
JOIN Enrollments AS e ON e.StudentID = s.StudentID
JOIN Courses AS c ON c.CourseID = e.CourseID
ORDER BY s.StudentID, c.CourseID;

-- Q11. LEFT JOIN: all students, including Nina with NULL course columns.
SELECT s.StudentID, CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
       c.CourseID, c.CourseName, e.EnrollmentDate
FROM Students AS s
LEFT JOIN Enrollments AS e ON e.StudentID = s.StudentID
LEFT JOIN Courses AS c ON c.CourseID = e.CourseID
ORDER BY s.StudentID, c.CourseID;

-- Q12. Students in courses with more than ten enrollments.
-- This returns no rows for the supplied sample data.
SELECT DISTINCT s.StudentID, CONCAT(s.FirstName, ' ', s.LastName) AS FullName, s.Email
FROM Students AS s
JOIN Enrollments AS e ON e.StudentID = s.StudentID
WHERE e.CourseID IN (
    SELECT CourseID
    FROM Enrollments
    GROUP BY CourseID
    HAVING COUNT(StudentID) > 10
)
ORDER BY s.StudentID;

-- Same pattern with a lower threshold to show results on the sample data.
SELECT DISTINCT s.StudentID, CONCAT(s.FirstName, ' ', s.LastName) AS FullName, s.Email
FROM Students AS s
JOIN Enrollments AS e ON e.StudentID = s.StudentID
WHERE e.CourseID IN (
    SELECT CourseID
    FROM Enrollments
    GROUP BY CourseID
    HAVING COUNT(StudentID) > 2
)
ORDER BY s.StudentID;

-- Q13. Extract date parts from student enrollment dates.
SELECT StudentID, CONCAT(FirstName, ' ', LastName) AS FullName,
       EnrollmentDate, YEAR(EnrollmentDate) AS EnrollmentYear,
       MONTH(EnrollmentDate) AS EnrollmentMonth,
       MONTHNAME(EnrollmentDate) AS EnrollmentMonthName,
       DATE_FORMAT(EnrollmentDate, '%Y') AS YearFormatted
FROM Students
ORDER BY EnrollmentDate, StudentID;

-- Q14. Format instructor names.
SELECT InstructorID, FirstName, LastName,
       CONCAT(FirstName, ' ', LastName) AS FullName,
       CONCAT_WS(' ', FirstName, LastName) AS FullNameAlt,
       CONCAT(LastName, ', ', FirstName) AS NameLastFirst,
       UPPER(CONCAT(FirstName, ' ', LastName)) AS FullNameUpper
FROM Instructors
ORDER BY InstructorID;

-- Q15. Running count of enrollment rows by date.
SELECT e.EnrollmentID, e.EnrollmentDate, c.CourseID, c.CourseName,
       s.StudentID,
       COUNT(e.StudentID) OVER (
           ORDER BY e.EnrollmentDate, e.EnrollmentID
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS RunningTotalStudents
FROM Enrollments AS e
JOIN Courses AS c ON c.CourseID = e.CourseID
JOIN Students AS s ON s.StudentID = e.StudentID
ORDER BY e.EnrollmentDate, e.EnrollmentID;

-- Bonus: running count restarts for each course.
SELECT e.EnrollmentID, c.CourseID, c.CourseName, e.EnrollmentDate,
       COUNT(e.StudentID) OVER (
           PARTITION BY c.CourseID
           ORDER BY e.EnrollmentDate, e.EnrollmentID
       ) AS RunningTotalPerCourse
FROM Enrollments AS e
JOIN Courses AS c ON c.CourseID = e.CourseID
ORDER BY c.CourseID, e.EnrollmentDate, e.EnrollmentID;

-- Q16. Classify students based on enrollment age.
SELECT StudentID, CONCAT(FirstName, ' ', LastName) AS FullName,
       EnrollmentDate, CURDATE() AS Today,
       DATEDIFF(CURDATE(), EnrollmentDate) AS DaysSinceEnrollment,
       ROUND(DATEDIFF(CURDATE(), EnrollmentDate) / 365, 2) AS YearsSinceEnrollment,
       CASE
           WHEN DATEDIFF(CURDATE(), EnrollmentDate) > (4 * 365) THEN 'Senior'
           ELSE 'Junior'
       END AS StudentLevel
FROM Students
ORDER BY EnrollmentDate, StudentID;

-- Bonus: number of students in each classification.
SELECT CASE
           WHEN DATEDIFF(CURDATE(), EnrollmentDate) > (4 * 365) THEN 'Senior'
           ELSE 'Junior'
       END AS StudentLevel,
       COUNT(*) AS StudentCount
FROM Students
GROUP BY StudentLevel;
