-- Relationships-one to many&joints of tables-----------------

SELECT 
    *
FROM
    customers
        INNER JOIN
    orders ON orders.customer_id = customers.id;

USE shop;

SELECT * FROM orders;

-- inner join
SELECT first_name, last_name, order_date FROM customers
JOIN orders ON orders.customer_id = customers.id;


-- left join
SELECT first_name, last_name, order_date FROM customers
LEFT JOIN orders ON orders.customer_id = customers.id;

SELECT first_name, last_name, IFNULL(SUM(amount), 0) as money_spend FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id
GROUP BY first_name, last_name;

INSERT INTO orders (amount, order_date)  VALUES (100, CURDATE());

SELECT * FROM orders;
SELECT first_name, last_name, order_date amount FROM customers 
RIGHT JOIN orders
ON customers.id = orders.customer_id;

CREATE TABLE students (
id INT PRIMARY KEY auto_increment,
first_name VARCHAR(100)
);

CREATE TABLE papers (
title VARCHAR(100),
grade INT,
student_id  INT,
FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

INSERT INTO students (first_name) VALUES 
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');
 
INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

SELECT * FROM students;
SELECT * FROM papers;

SELECT 
    first_name,
    IFNULL(AVG(grade), 0) AS average,
    CASE
        WHEN AVG(grade) > 0 THEN 'PASSING'
        ELSE 'FAILING'
    END AS passing_status
FROM
    students
        LEFT JOIN
    papers ON papers.student_id = students.id
GROUP BY first_name
ORDER BY average DESC;



SELECT first_name, IFNULL(title, 'MISSING'), IFNULL(grade,0) FROM students
LEFT JOIN papers
ON papers.student_id = students.id

--  many to many relationships

CREATE TABLE reviewers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

CREATE TABLE series (
id INT PRIMARY KEY auto_increment,
title VARCHAR(100),
released_year YEAR,
genre VARCHAR(100)
);

CREATE TABLE reviews (
id INT PRIMARY KEY auto_increment,
rating DECIMAL(2,1),
series_id INT,
reviewer_id INT,
FOREIGN KEY (series_id) REFERENCES series(id) ON DELETE CASCADE,
FOREIGN KEY (reviewer_id) REFERENCES reviewers(id) ON DELETE CASCADE
);




INSERT INTO series (title, released_year, genre) VALUES
    ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ("Fargo", 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');

INSERT INTO reviewers (first_name, last_name) VALUES
    ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');

INSERT INTO reviews(series_id, reviewer_id, rating) VALUES
    (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
    (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
    (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
    (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
    (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
    (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
    (7,2,9.1),(7,5,9.7),
    (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
    (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
    (10,5,9.9),
    (13,3,8.0),(13,4,7.2),
    (14,2,8.5),(14,3,8.9),(14,4,8.9);

SELECT title, ROUND(AVG(rating), 2) AS avg_rating FROM series
JOIN reviews ON reviews.series_id = series.id
GROUP BY title
ORDER BY avg_rating;

SELECT * FROM reviewers;

SELECT first_name, last_name, ROUND(rating, 2) FROM reviewers
JOIN reviews ON reviews.reviewer_id = reviewers.id
ORDER BY first_name;

SELECT * FROM reviews;

SELECT title AS unreviewed_series FROM series
LEFT JOIN reviews ON reviews.series_id = series.id
WHERE rating IS NULL;

SELECT * FROM reviews;
SELECT * FROM series;
SELECT * FROM reviewers;


SELECT genre, AVG(rating) AS avg_rating FROM series
JOIN reviews ON reviews.series_id = series.id
GROUP BY genre;

SELECT 
    first_name,
    last_name,
    COUNT(rating) AS count,
    IFNULL(MIN(rating), 0) AS MIN,
    IFNULL(MAX(rating),0) AS MAX,
    ROUND(IFNULL(AVG(Rating), 0), 2) AS average,
    CASE
        WHEN COUNT(rating) = 0 THEN 'INACTIVE'
        ELSE 'ACTIVE'
    END AS STATUS
FROM
    reviewers
        LEFT JOIN
    reviews ON reviews.reviewer_id = reviewers.id
GROUP BY first_name , last_name;

SELECT * FROM reviews;

SELECT title, rating, CONCAT(first_name,' ',last_name) AS reviewer FROM reviews
JOIN series ON series.id = reviews.series_id
JOIN reviewers ON reviewers.id = reviews.reviewer_id
ORDER BY title;

-- --------------------------------------VIEW ------------------------------------
-- view is a virtual table 
-- create a view

CREATE VIEW full_reviews AS
SELECT title, rating, CONCAT(first_name,' ',last_name) AS reviewer FROM reviews
JOIN series ON series.id = reviews.series_id
JOIN reviewers ON reviewers.id = reviews.reviewer_id;

SELECT * FROM full_reviews;
-- some views are updateable, some are not 
-- replace/alter views

CREATE VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year;

CREATE OR REPLACE VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year DESC;

DROP VIEW ordered_series;

-- GROUP BY XX HAVING XXX
SELECT title
FROM full_reviews
GROUP BY title HAVING COUNT(rating) > 1;

-- GROUP BY XX WITH ROLLUP; 
SELECT title, AVG(rating) FROM full_reviews GROUP BY title WITH ROLLUP;

 -- SQL MODES;
SELECT @@GLOBAL.sql_mode;
SELECT @@SESSION.sql_mode;

-- get rid of all the restrictions in SESSION mode.
SET SESSION sql_mode = 'ONLY_FULL_GROUP_BY'; 

-- WINDOW FUNCTIONS perform aggregate operations on groups of rows, but they produce a result for each row.






