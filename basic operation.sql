-- CREATE TABLE unique_cats( cat_id INT auto_increment, name VARCHAR(50), age INT, PRIMARY KEY(cat_id) );
CREATE TABLE Employees(
id INT auto_increment PRIMARY KEY,
last_name VARCHAR(50) NOT NULL,
first_name VARCHAR(50) NOT NULL,
middle_name VARCHAR(50),
age INT NOT NULL,
current_status VARCHAR(50) NOT NULL DEFAULT 'employed');

DESC Employees;

INSERT INTO Employees (first_name, last_name, age) VALUES('thoms', 'shelby',35);

SELECT * FROM Employees;

SELECT cat_id, age FROM cats WHERE cat_id=age;

SELECT cat_id,breed FROM cats WHERE name='Ringo';

UPDATE cats SET age=12 WHERE (breed='Maine Coon' AND cat_id IN (2,3));

SELECT * FROM cats;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM cats WHERE age=4;

DELETE FROM cats WHERE age=cat_id;
DELETE FROM cats;
SELECT * FROM cats;
SHOW DATABASES;

CREATE DATABASE shirts_db;
SHOW DATABASES;
USE shirts_db;
CREATE TABLE shirts(
shirt_id INT auto_increment PRIMARY KEY,
article VARCHAR(50) NOT NULL,
color VARCHAR(50) NOT NULL,
shirt_size VARCHAR(3) NOT NULL,
last_worn INT NOT NULL
);
DESC shirts;
INSERT INTO shirts (article,color,shirt_size,last_worn) VALUES
('t-shirt', 'white', 'S', 10),
('t-shirt', 'green', 'S', 200),
('polo shirt', 'black', 'M', 10),
('tank top', 'blue', 'S', 50),
('t-shirt', 'pink', 'S', 0),
('polo shirt', 'red', 'M', 5),
('tank top', 'white', 'S', 200),
('tank top', 'blue', 'M', 15);

INSERT INTO shirts(color,article,shirt_size,last_worn) VALUES
('Purple','polo shirt','M',50);

SELECT article,color FROM shirts;
SELECT color,article,shirt_size,last_worn FROM shirts WHERE shirt_size='M';
UPDATE shirts SET shirt_size='M' WHERE article='polo shirt';
UPDATE shirts SET shirt_size='L' WHERE article='polo shirt';
UPDATE shirts SET last_worn=0 WHERE last_worn=15;
UPDATE shirts SET shirt_size='XS', color='off white' WHERE color='white';
DELETE FROM shirts WHERE last_worn=200;
DELETE FROM shirts WHERE article='tank tops';
DELETE FROM shirts;
DROP TABLE shirts;
SELECT * FROM shirts;
SHOW TABLES;
DESC shirts;






