CREATE TABLE books 
	(
		book_id INT NOT NULL AUTO_INCREMENT,
		title VARCHAR(100),
		author_fname VARCHAR(100),
		author_lname VARCHAR(100),
		released_year INT,Employees
		stock_quantity INT,
		pages INT,
		PRIMARY KEY(book_id)
	)

INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343)

SELECT 
    CONCAT(author_fname, ' ', author_lname) AS author_name
FROM
    books;
SELECT CONCAT_WS('-',author_fname,author_lname) AS author_name FROM books;
SELECT 
    SUBSTR(title, 1, 15)
FROM
    books;
SELECT 
    CONCAT(SUBSTR(title, 1, 10), '...') AS short_title
FROM
    books;

SELECT 
    CONCAT(SUBSTR(author_fname, 1, 1),
            '.',
            SUBSTR(author_lname, 1, 1)) AS author_initials
FROM
    books;

SELECT REPLACE('HELLO WORLD','H','E');
SELECT REPLACE(title,' ', '-') FROM books;
SELECT REVERSE('CHICKEN NUGGETS');
SELECT REVERSE(author_fname) FROM books;
SELECT CONCAT(author_fname, REVERSE(author_fname)) FROM books;
SELECT CHAR_LENGTH(author_fname) AS len, author_fname FROM books;
SELECT UPPER(author_fname) FROM books;
SELECT LCASE(author_lname) FROM books;
SELECT LEFT(author_fname,5) FROM books;
SELECT INSERT('Hello Bobby', 6, 0, 'There'); 
SELECT TRIM('  pickle  ');

SELECT UCASE(REVERSE('Why does my cat look at me with such hatred?'));

SELECT REPLACE(title,' ', '->') AS title FROM books;

SELECT author_lname AS forwards, REVERSE(author_lname) AS backwards FROM books;

SELECT CONCAT(UCASE(author_fname), ' ', UCASE(author_lname)) AS full_name_in_caps FROM books;

SELECT CONCAT(title, ' was released in ', released_year) AS blurb FROM books;

SELECT title, CHAR_LENGTH(title) AS character_count FROM books;

SELECT CONCAT(SUBSTR(title,1,10),'...') AS short_title, 
CONCAT(author_fname, ',',author_lname) AS author, CONCAT(stock_quantity, ' in stock') AS quantity 
FROM books;

INSERT INTO books
    (title, author_fname, author_lname, released_year, stock_quantity, pages)
    VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
           ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
           ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);

SELECT DISTINCT author_lname FROM books;
SELECT DISTINCT released_year FROM books;
SELECT DISTINCT CONCAT(author_fname, ' ', author_lname) FROM books;
SELECT author_fname,author_lname FROM books ORDER BY author_lname DESC;
SELECT author_fname FROM books WHERE author_fname LIKE '%da%';
SELECT * FROM books WHERE author_fname LIKE '___';
SELECT * FROM books WHERE title LIKE '%\%%';
SELECT * FROM books WHERE title LIKE '%\_%';

SELECT title FROM books WHERE title LIKE '%stories%';

SELECT title, pages FROM books ORDER BY pages DESC LIMIT 1;

SELECT CONCAT(title, ' - ', released_year) AS summary FROM books ORDER BY released_year DESC LIMIT 3;

SELECT title, author_lname FROM books WHERE author_lname LIKE '% %';

SELECT title, released_year, stock_quantity FROM books ORDER BY stock_quantity,title LIMIT 3;

SELECT title, author_lname FROM books ORDER BY author_lname, title;

SELECT CONCAT('MY FAVORITE AUTHOR IS ',UCASE(author_fname),' ',UCASE(author_lname), ' !') AS yell FROM books ORDER BY author_lname;


SELECT COUNT(*) FROM books;
SELECT COUNT(author_fname) FROM books;
SELECT COUNT(DISTINCT author_fname) FROM books;
SELECT COUNT(DISTINCT released_year) FROM books;
SELECT COUNT(*) FROM books WHERE title LIKE '%the%';

-- GROUP BY
SELECT author_lname, COUNT(*) AS books_written FROM books GROUP BY author_lname ORDER BY books_written DESC;
SELECT MIN(released_year) FROM books;
SELECT MAX(pages) FROM books;

SELECT title, pages FROM books ORDER BY pages DESC LIMIT 1;

SELECT title, pages FROM books
WHERE pages = (SELECT MAX(pages) FROM books); 

INSERT INTO books (title,pages) VALUES('my life in word', 634);

SELECT title, pages FROM books
WHERE pages = (SELECT MAX(pages) FROM books); 

SELECT author_lname, count(*) FROM books GROUP BY author_lname;

SELECT  author_fname, author_lname, MIN(released_year) FROM books GROUP BY author_fname, author_lname;

SELECT AVG(released_year) FROM books;

SELECT AVG(stock_quantity),COUNT(*), released_year FROM books GROUP BY released_year;


SELECT COUNT(*) FROM books;

SELECT released_year, COUNT(*) FROM books GROUP BY released_year ORDER BY released_year;

SELECT author_lname, author_fname,AVG(released_year) FROM books GROUP BY author_lname, author_fname;

SELECT CONCAT(author_fname, ' ', author_lname) AS full_name FROM books WHERE pages=(SELECT MAX(pages) FROM books);

SELECT released_year AS year, COUNT(*) AS '# books', AVG(pages) AS 'avg pages' FROM books GROUP BY released_year ORDER BY released_year;

-- SQL DATA TYPES
-- CHAR is faster for fixed length text
-- INT, CHAR, VARCHAR
-- DECIMAL(13,2)
-- FLOAT can store larger numbers using less space, but it comes at the cost of precision
-- DATE, TIME, DATETIME
-- CURDATE, CURTIME, NOW


CREATE TABLE products (price DECIMAL(5,2));

SELECT CURTIME();
SELECT CURDATE();
SELECT NOW();

-- DATE functions;
-- DAY, DAYOFWEEK, DAYOFYEAR, MONTHNAME, WEEKOFYEAR
SELECT birthdate, DAY(birthdate) FROM people;

-- TIME functions;
-- HOUR, MINUTE,SECOND

SELECT DATE_FORMATE(birthdate, '%b') FROM people;
SELECT DATEDIFF(CURDATE(), birthdate) FROM people;
SELECT DATE_ADD(CURDATE(),INTERVAL 12 YEAR);
SELECT DATE_SUB(CURDATE(),INTERVAL 12 YEAR);
SELECT birthdate, YEAR(birthdate + INTERVAL 21 YEAR) FROM people;

-- DATETIME VS TIMESTAMP. TIMESTAMP takes less storage room.alter

CREATE TABLE captions(
text VARCHAR(150),
dt TIMESTAMP default CURRENT_TIMESTAMP
);

INSERT INTO captions (text) VALUES ('just me and the girls chillin');

CREATE TABLE captions2(
text VARCHAR(150),
dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ut TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO captions2 (text) VALUES ('I LOVE LIFE');

SELECT * FROM captions2;

UPDATE captions2 SET text='i love life!!!!';

SELECT * FROM captions2;

SELECT CURTIME();
SELECT CURDATE();
SELECT NOW();
SELECT DAYOFWEEK(CURDATE());

SELECT title, author_fname, author_lname FROM books WHERE author_fname NOT LIKE 'da%';
SELECT title, released_year FROM books WHERE released_year NOT BETWEEN 2004 AND 2015;

SELECT * FROM people WHERE birthtime 
BETWEEN CAST('12:00:00' AS TIME)
AND CAST('16:00:00' AS TIME);

SELECT * FROM people WHERE HOUR(birthtime)
BETWEEN 12 AND 16;

SELECT title, author_lname FROM books 
WHERE author_lname NOT IN ('carver', 'lahiri', 'smith');

SELECT 
    title,
    released_year,
    CASE
        WHEN released_year >= 2000 THEN 'modern lit'
        ELSE '20th century lit'
    END AS genre
FROM
    books;
    
DELETE FROM books WHERE title IS NULL;

SELECT title FROM books WHERE released_year < 1980;
SELECT title, author_lname FROM books WHERE author_lname = 'Eggers' OR author_lname = 'Chabon';
SELECT title,pages FROM books WHERE  pages BETWEEN 100 AND 200;
SELECT title, author_lname FROM books WHERE author_lname LIKE 'C%' OR author_lname LIKE 'S%';

SELECT 
    title,
    author_lname,
    CASE
        WHEN title LIKE '%stories%' THEN 'Short Stories'
        WHEN title = 'Just kids' THEN 'Memoir'
        WHEN title = 'A Heartbreaking Work of Staggering Genius' THEN 'Memoir'
        ELSE 'Novel'
    END AS TYPE
FROM
    books;
    
SELECT author_fname, author_lname, 
CASE 
WHEN COUNT(*)=1 THEN CONCAT(COUNT(*), ' ', 'book')
ELSE CONCAT(COUNT(*), ' ', 'books')
END AS COUNT
FROM books 
WHERE author_fname IS NOT NULL
GROUP BY author_fname, author_lname;

CREATE TABLE partiers (
name VARCHAR(50),
age INT CHECK (age > 0)
);

CREATE TABLE palindromes (
    word VARCHAR(100),
    CONSTRAINT word_not_palindromes CHECK (REVERSE(word) = word)
);

SELECT * FROM palindromes;

CREATE TABLE companies (
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    CONSTRAINT name_address UNIQUE (name , address)
);

ALTER TABLE suppliers
ADD CONSTRAINT positive_price  CHECK(purchase_price >= 0);


ALTER TABLE companies 
ADD COLUMN phone VARCHAR(15) NOT NULL;

ALTER TABLE companies
DROP COLUMN phone;

ALTER TABLE suppliers
RENAME COLUMN name TO company_name;

ALTER TABLE suppliers 
RENAME TO companies;

-- use MODIFY to change an existing column's type;
ALTER TABLE supplEmployeesiers
MODIFY biz_name VARCHAR(100) DEFAULT 'unknown';

-- use CHANGE to rename a column  change its data type

ALTER TABLE suppliers
CHANGE business biz_name VARCHAR(100);

-- -------------------------Relationships-one to many&joints of tables----------------------

-- one to many relationship
CREATE TABLE customers(
id INT PRIMARY KEY auto_increment,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(50)
);

DROP TABLE customers;

-- ON DELETE CASCADE
CREATE TABLE orders (
id INT PRIMARY KEY auto_increment,
order_date DATE,
amount DECIMAL(8,2),
customer_id INT,
FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS products (
product_id INT PRIMARY KEY,
low_fats ENUM('Y','N')
);

-- deletes the data inside a table, but not the table itself.
TRUNCATE TABLE products; 

-- delete a table
DROP TABLE shippers;

-- COALESCE return the first non-null value.
SELECT name FROM Customer WHERE COALESCE(referee_id,0) <>2;

-- DISTINCT is used to return only distinct(different) values.
SELECT DISTINCT country_name FROM contries;







