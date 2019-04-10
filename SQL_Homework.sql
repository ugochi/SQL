use sakila;

-- Display the first and last names of all actors from the table actor.
SELECT first_name, last_name
FROM actor;

-- Display the first and last name of each actor in a single column in upper case letters. 
-- Name the column Actor Name.
SELECT UPPER(CONCAT(first_name, " ", last_name)) AS "Actor Name"
FROM actor;

-- Find the ID number, first name, and last name of an actor, where first name is  "Joe."
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = "Joe";

-- Find all actors whose last name contain the letters GEN:
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name like "%GEN%";

-- Find all actors whose last names contain the letters LI. order the rows by last name and first name
SELECT actor_id, last_name, first_name
FROM actor
WHERE last_name like "%LI%";

-- Using IN, display the country_id and country columns of the following countries: 
-- Afghanistan, Bangladesh, and China:
SELECT country_id, country
FROM country
WHERE country IN ("Afghanistan", "Bangladesh", "China");

-- create a column in the table actor named description and use the data type BLOB
ALTER TABLE actor
ADD COLUMN description BLOB;

-- Delete the description column.
ALTER TABLE actor
DROP COLUMN description;

-- List the last names of actors, as well as how many actors have that last name 
SELECT last_name, 
COUNT(*) AS "Number of Actors"
FROM actor
GROUP BY last_name;

-- List last names of actors and the number of actors who have that last name, 
-- but only for names that are shared by at least two actors.
SELECT last_name, 
COUNT(*) AS "Number of Actors"
FROM actor
GROUP BY last_name
HAVING COUNT(*) >= 2;

-- The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. 
-- Write a query to fix the record.
UPDATE actor
SET first_name = "HARPO"
WHERE last_name = "WILLIAMS" AND first_name = "GROUCHO";

-- change HARPO back to GROUCHO
UPDATE actor
SET first_name = "GROUCHO"
WHERE last_name = "WILLIAMS" AND first_name = "HARPO";

-- You cannot locate the schema of the address table. Which query would you use to re-create it?
DESCRIBE sakila.address;




