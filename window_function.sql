
-- WINDOW FUNCTIONS perform aggregate operations on groups of rows, but they produce a result for each row.
-- We take big chunk of data, partition it into windows, do some analysis, then recombine them into one big table.

USE shop;
SHOW tables;

SELECT emp_no, department, salary, AVG(salary) OVER(PARTITION BY department) AS dept_avg FROM employees;


SELECT emp_no, department, salary, SUM(salary) OVER(), MAX(salary) OVER() FROM employees;

SELECT emp_no, department, salary, SUM(salary) OVER(PARTITION BY department) AS depart_sum FROM employees;

-- without out partition by, we get a window with all rows, with partition by, we get several small windows divided by the partition variable.
SELECT emp_no, department, salary, 
SUM(salary) OVER(PARTITION BY department) AS dept_salary,
SUM(salary) OVER(PARTITION BY department ORDER BY salary) AS rolling_dept_salary
FROM employees;


-- RANK()
SELECT 
emp_no,
department,
salary,
RANK() OVER(PARTITION BY department ORDER BY salary) AS dept_salary_rank,
RANK() OVER(ORDER BY salary) AS overall_salary_rank
FROM employees
ORDER BY department;

-- ROW NUMBER(), the row_number of each row in the specific small window.
SELECT 
emp_no,
department,
salary,
ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary) AS row_numner,
RANK() OVER(PARTITION BY department ORDER BY salary) AS dept_salary_rank,
RANK() OVER(ORDER BY salary) AS overall_salary_rank
FROM employees
ORDER BY department;


-- DENSE_RANK(), doesn't skip any number
SELECT 
emp_no,
department,
salary,
DENSE_RANK() OVER(ORDER BY salary DESC) AS overall_d_rank,
RANK() OVER(ORDER BY salary DESC) AS overall_rank
FROM employees;

-- NTILE()
SELECT emp_no, department, salary, 
NTILE(4) OVER(ORDER BY salary DESC) AS salary_quartile,
NTILE(4) OVER(PARTITION BY department ORDER BY salary DESC) AS salary_d_quartile
FROM employees;

-- FIRST VALUE,the id of the highsest paid employee
SELECT emp_no, department, salary, 
FIRST_VALUE(emp_no) OVER(ORDER BY salary DESC)
FROM employees;

-- LAG, the previous salary for each row in a given window.
SELECT emp_no, department, salary, 
LAG(salary) OVER(ORDER BY salary DESC)
FROM employees;

SELECT emp_no, department, salary, 
salary - LAG(salary) OVER(ORDER BY salary DESC) AS salary_dif
FROM employees;

-- LEAD the next row of salary for each row in a given window.
SELECT emp_no, department, salary, 
LEAD(salary) OVER(ORDER BY salary DESC),
salary - LEAD(salary) OVER(ORDER BY salary DESC) AS salary_dif
FROM employees;

CREATE TABLE users (
id INT PRIMARY KEY auto_increment,
username VARCHAR(255) UNIQUE NOT NULL,
created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photos (
id INT PRIMARY KEY auto_increment,
image_url VARCHAR(255) NOT NULL,
user_id INT NOT NULL,
FOREIGN KEY (user_id) REFERENCES users(id),
created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE comments (
id INT PRIMARY KEY auto_increment,
comment_text VARCHAR(255) NOT NULL,
user_id INT NOT NULL,
FOREIGN KEY (user_id) REFERENCES users(id),
created_at TIMESTAMP DEFAULT NOW(),
photo_id INT NOT NULL,
FOREIGN KEY (photo_id) REFERENCES photos(id)
);

CREATE TABLE likes (
user_id INT NOT NULL,
FOREIGN KEY (user_id) REFERENCES users(id),
created_at TIMESTAMP DEFAULT NOW(),
photo_id INT NOT NULL,
FOREIGN KEY (photo_id) REFERENCES photos(id),
PRIMARY KEY(user_id, photo_id)
);

CREATE TABLE follows (
follower_id INT NOT NULL,
followee_id INT NOT NULL,
created_at TIMESTAMP DEFAULT NOW(),
FOREIGN KEY (follower_id) REFERENCES users(id),
FOREIGN KEY (followee_id) REFERENCES users(id),
PRIMARY KEY(follower_id, followee_id)
);

CREATE TABLE tags (
id INT auto_increment PRIMARY KEY,
tage_name VARCHAR(100) UNIQUE,
create_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photo_tags (
photo_id INT NOT NULL,
tag_id INT NOT NULL,
FOREIGN KEY (photo_id) REFERENCES photos(id),
FOREIGN KEY (tag_id) REFERENCES tags(id),
PRIMARY KEY(photo_id, tag_id)
);











