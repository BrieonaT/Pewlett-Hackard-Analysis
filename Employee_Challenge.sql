 -- ~~~~~~~~~~~~~~~~~~~~~ Deliverable 1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 1. Retrieve the emp_no, first_name, and last_name columns from the Employees table.
SELECT employees.emp_no, employees.first_name, employees.last_name
FROM employees;

-- 2. Retrieve the title, from_date, and to_date columns from the Titles table.
SELECT titles.title, titles.from_date, titles.to_date
FROM titles;


-- 3. Create a new table using the INTO clause.
SELECT emp.emp_no, emp.first_name, emp.last_name,
	   ti.title, ti.from_date, ti.to_date
INTO retirement_titles
FROM employees as emp
INNER JOIN titles as ti
-- 4. Join both tables on the primary key.
ON (ti.emp_no = emp.emp_no)
-- 5. Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number.
WHERE (emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp.emp_no;

-- 6. Export the Retirement Titles table from the previous step as retirement_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.
   --retirement_titles.csv created
   
-- 7. Copy the query from the Employee_Challenge_starter_code.sql and add it to your Employee_Database_challenge.sql file.
-- 8. Retrieve the employee number, first and last name, and title columns from the Retirement Titles table. These columns will be in the new table that will hold the most recent title of each employee.
SELECT emp_no, first_name, last_name, title
FROM retirement_titles;

-- 9. Use the DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
			-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
-- 10. Create a Unique Titles table using the INTO clause.
INTO unique_titles
FROM retirement_titles
-- 11. Sort the Unique Titles table in ascending order by the employee number and descending order by the last date (i.e. to_date) of the most recent title.
ORDER BY emp_no, to_date DESC;


-- Write another query in the Employee_Database_challenge.sql file to retrieve the number of employees by their most recent job title who are about to retire.
-- 13. First, retrieve the number of titles from the Unique Titles table.
SELECT COUNT(first_name), title
-- 14. Then, create a Retiring Titles table to hold the required information.
INTO retiring_title_count
FROM unique_titles
-- 15. Group the table by title, then sort the count column in descending order.
GROUP BY title 
ORDER BY COUNT(title) DESC;
-- 16. Export the Retiring Titles table as retiring_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.
		--retiring_titles.csv



-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Deliverable 2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


-- In the Employee_Database_challenge.sql file, write a query to create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program.

-- 1. Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table.
-- 2. Retrieve the from_date and to_date columns from the Department Employee table.
-- 3. Retrieve the title column from the Titles table.
-- 4. Use a DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
SELECT DISTINCT ON (employees.emp_no) employees.emp_no, employees.first_name, employees.last_name, employees.birth_date, dept_emp.from_date, dept_emp.to_date, titles.title
-- 5. Create a new table using the INTO clause.
INTO mentorship_eligibility
FROM employees
-- 6. Join the Employees and the Department Employee tables on the primary key.
INNER JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
-- 7. Join the Employees and the Titles tables on the primary key.
INNER JOIN titles ON titles.emp_no = employees.emp_no
-- 8. Filter the data on the to_date column to all the current employees, then filter the data on the birth_date columns to get all the employees whose birth dates are between January 1, 1965 and December 31, 1965.
WHERE (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	  AND (dept_emp.to_date='9999-01-01')
-- 9. Order the table by the employee number.
ORDER BY emp_no;

-- 10. Export the Mentorship Eligibility table as mentorship_eligibilty.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.
	--mentorship_eligibilty.csv





-- Extra for README analysis
SELECT COUNT(emp_no), title
FROM mentorship_eligibility
GROUP BY title 
ORDER BY COUNT(title) DESC;
