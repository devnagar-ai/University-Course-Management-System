# University Course Management System

A MySQL 8.0+ learning project that models students, courses, instructors, enrollments, and departments. It demonstrates CRUD operations, joins, subqueries, aggregation, date and string functions, a window function, and `CASE` expressions.

## Requirements

- MySQL 8.0 or later
- MySQL Workbench or the MySQL command-line client

## Schema

- **Departments** organizes courses and instructors.
- **Students** stores student details.
- **Courses** belongs to a department.
- **Instructors** belongs to a department and includes an assumed `Salary` column for the maximum salary query.
- **Enrollments** links students and courses, with one enrollment allowed per student/course pair.

The `Enrollments` junction table represents the many-to-many relationship between students and courses. Foreign keys cascade deletes and updates. The schema script does not drop an existing database.

## Run the project

Run these scripts in order from MySQL Workbench or a MySQL command-line session:

```sql
SOURCE schema.sql;
SOURCE sample_data.sql;
SOURCE crud_operations.sql;
```

Then run examples from `queries.sql`. The CRUD script adds extra sample rows and performs updates; run it once after loading the sample data. Its `DELETE` examples are commented out. Queries using `CURDATE()` change over time.

## Files

| File | Description |
| --- | --- |
| `schema.sql` | Creates `UniversityDB` and its five related tables. |
| `sample_data.sql` | Loads the departments, students, courses, instructors, and enrollments. |
| `crud_operations.sql` | Demonstrates insert, select, update, and delete operations on all tables. |
| `queries.sql` | Filtering, aggregation, joins, subqueries, date/string functions, windows, and `CASE`. |

## Assumptions

- MySQL 8.0+ is used for window functions.
- `Instructors.Salary` is included because the project asks for the maximum instructor salary, although the original schema omitted it.
- `EnrollmentDate` and `BirthDate` use MySQL `DATE` values.
- A student is labeled Senior if their enrollment date is more than `4 * 365` days ago; otherwise they are labeled Junior.
- The sample dataset is fictional. Course counts are intentionally suitable for demonstrating `HAVING`; the `COUNT(*) > 10` subquery returns no rows with the sample data.

## Concepts covered

- CRUD operations and primary/foreign keys
- `WHERE`, `ORDER BY`, `LIMIT`, `GROUP BY`, and `HAVING`
- `INNER JOIN` and `LEFT JOIN`
- Intersection and union-style filtering
- `AVG()`, `MAX()`, and `COUNT()`
- `YEAR()`, `MONTH()`, `MONTHNAME()`, `DATE_FORMAT()`, and `DATEDIFF()`
- `CONCAT()`, `CONCAT_WS()`, and `UPPER()`
- Running totals with `COUNT() OVER (...)`
- `CASE` for Senior/Junior classification

## Author

By ved.
