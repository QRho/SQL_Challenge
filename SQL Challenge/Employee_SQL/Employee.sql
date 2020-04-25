

CREATE TABLE employees (
   emp_no INTEGER NOT NULL,
   birth_date DATE NOT NULL,
   first_name VARCHAR NOT NULL,
   last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
 PRIMARY KEY (emp_no)
);

CREATE TABLE salaries (
   emp_no INTEGER NOT NULL,
   salary INTEGER NOT NULL,
   from_date DATE NOT NULL,
   to_date DATE NOT NULL,
   FOREIGN KEY (emp_no)REFERENCES employees (emp_no),
   PRIMARY KEY (emp_no,salary)
);

CREATE TABLE departments (
  dept_no VARCHAR NOT NULL,
  dept_name VARCHAR NOT NULL,
 PRIMARY KEY (dept_no)
	);
	
	
	
CREATE TABLE dept_emp (
   emp_no INTEGER NOT NULL,
   dept_no VARCHAR NOT NULL,
   from_date DATE NOT NULL,
   to_date DATE NOT NULL,
   PRIMARY KEY (emp_no,dept_no),
   FOREIGN KEY (dept_no)REFERENCES departments (dept_no),
   FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

	
CREATE TABLE dept_manager (
   dept_no VARCHAR NOT NULL,
   emp_no INTEGER NOT NULL,
   from_date DATE NOT NULL,
   to_date DATE NOT NULL,
   PRIMARY KEY (dept_no,emp_no),
   FOREIGN KEY (dept_no)REFERENCES departments (dept_no),
   FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);
	

CREATE TABLE titles (
   emp_no INTEGER NOT NULL,
   title TEXT NOT NULL,
   from_date DATE NOT NULL,
   to_date DATE NOT NULL,
   PRIMARY KEY (emp_no,from_date),
   FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);
---1. List the following details of each employee: employee number,
---last name, first name, gender, and salary.

SELECT employees.emp_no,employees.last_name,employees.first_name,employees.gender,salaries.salary
FROM employees
LEFT JOIN salaries ON
salaries.emp_no=employees.emp_no	
;

---2. List employees who were hired in 1986.
SELECT *
FROM employees
WHERE hire_date
BETWEEN '1986-01-01' AND '1986-12-31'

---3. List the manager of each department with the following information: department number, department name, the manager's employee number, 
---last name, first name, and start and end employment dates.

SELECT departments.dept_no,departments.dept_name,dept_manager.emp_no AS manager_employee_number,
employees.last_name,employees.first_name,dept_manager.from_date,dept_manager.to_date
FROM dept_manager 
INNER JOIN departments ON
dept_manager.dept_no=departments.dept_no
INNER JOIN employees ON
dept_manager.emp_no=employees.emp_no


---4. List the department of each employee with the following information: 
---employee number, last name, first name, and department name.

SELECT employees.emp_no,employees.last_name,employees.first_name,
departments.dept_name
FROM dept_emp
INNER JOIN departments ON
dept_emp.dept_no=departments.dept_no
INNER JOIN employees ON
dept_emp.emp_no=employees.emp_no
 
 
 --5. List all employees whose first name is "Hercules" and last names begin with "B."
 
SELECT employees.first_name,employees.last_name
FROM employees
WHERE first_name='Hercules'AND last_name LIKE 'B%'


--6.List all employees in the Sales department, 
--including their employee number, last name, first name, and department name.


SELECT employees.emp_no,employees.last_name,employees.first_name,departments.dept_name
FROM dept_emp
INNER JOIN departments ON
dept_emp.dept_no=departments.dept_no
INNER JOIN employees ON
dept_emp.emp_no=employees.emp_no
WHERE dept_name = 'Sales'


--7. List all employees in the Sales and Development departments,
--including their employee number, last name, first name, and department name.

SELECT employees.emp_no,employees.last_name,employees.first_name,departments.dept_name
FROM dept_emp
INNER JOIN departments ON
dept_emp.dept_no=departments.dept_no
INNER JOIN employees ON
dept_emp.emp_no=employees.emp_no
WHERE dept_name IN ('Sales', 'Development');

--8. In descending order, list the frequency count of employee last names,
--i.e., how many employees share each last name.

SELECT last_name, COUNT(*) AS "How Many Instances"
FROM employees
GROUP BY last_name
ORDER BY "How Many Instances" DESC;


--BONUS Search ID 499942. LOL APRIL FOOLSDAY

SElECT *
FROM employees
WHERE emp_no ='499942';

