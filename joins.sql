-- Dataset: employee_data (my own project), tables: employees and departments
-- Join key: department_id

-- 8. Employees with their department names (INNER JOIN)
-- INNER JOIN keeps only the rows that match in both tables on department_id.
-- Mary Martin (department 5) has no matching department, so she is left out. Returned 5 rows.
SELECT
 employees.name AS employee_name,
 employees.role AS employee_role,
 departments.name AS department_name
FROM
 `project-cc781377-6842-4add-a3a.employee_data.employees` AS employees
INNER JOIN
 `project-cc781377-6842-4add-a3a.employee_data.departments` AS departments
ON employees.department_id = departments.department_id;

-- 9. All employees with their department names (LEFT JOIN)
-- LEFT JOIN keeps every row from employees, even when there is no matching department.
-- Mary Martin (department 5) has no matching department, so department_name is null. Returned 6 rows.
SELECT
 employees.name AS employee_name,
 employees.role AS employee_role,
 departments.name AS department_name
FROM
 `project-cc781377-6842-4add-a3a.employee_data.employees` AS employees
LEFT JOIN
 `project-cc781377-6842-4add-a3a.employee_data.departments` AS departments
ON employees.department_id = departments.department_id;

-- 10. All departments with their employees (RIGHT JOIN)
-- RIGHT JOIN keeps every row from departments, even when there is no matching employee.
-- Accounting and Sales have no employees, so employee_name and employee_role are null. Returned 7 rows.
SELECT
 employees.name AS employee_name,
 employees.role AS employee_role,
 departments.name AS department_name
FROM
 `project-cc781377-6842-4add-a3a.employee_data.employees` AS employees
RIGHT JOIN
 `project-cc781377-6842-4add-a3a.employee_data.departments` AS departments
ON employees.department_id = departments.department_id;

-- 11. All employees and all departments (FULL OUTER JOIN)
-- FULL OUTER JOIN keeps every row from both tables, matched on department_id where possible.
-- Mary Martin has a null department_name, and Accounting and Sales have null employee_name and employee_role. Returned 8 rows.
SELECT
 employees.name AS employee_name,
 employees.role AS employee_role,
 departments.name AS department_name
FROM
 `project-cc781377-6842-4add-a3a.employee_data.employees` AS employees
FULL OUTER JOIN
 `project-cc781377-6842-4add-a3a.employee_data.departments` AS departments
ON employees.department_id = departments.department_id;
