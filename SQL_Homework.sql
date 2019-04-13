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
DESCRIBE  sakila.address;

-- Use JOIN to display the first, last names and address of each staff member. 
-- Use the tables staff and address
SELECT first_name, last_name, address
FROM staff
INNER JOIN address
ON staff.address_id= address.address_id;

-- Use JOIN to display the total amount rung up by each staff member in August of 2005. 
-- Use tables staff and payment
SELECT p.staff_id, s.first_name, s.last_name, SUM(p.amount) as "Total Amount"
FROM staff AS s
JOIN payment AS p
ON s.staff_id= p.staff_id AND p.payment_date LIKE "2005-08%"
GROUP BY s.staff_id;

/* List each film and the number of actors who are listed for that film. 
Use tables film_actor and film. Use inner join */
SELECT f.title, COUNT(fa.actor_id) as "Count of Actors"
FROM film AS f
INNER JOIN film_actor AS fa
ON f.film_id= fa.film_id
GROUP BY f.title;

-- How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT COUNT(*) AS "Number of Copies"
FROM inventory
WHERE film_id
IN (
	SELECT film_id
    FROM film 
    WHERE title = "Hunchback Impossible"
);

/*Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
List the customers alphabetically by last name*/
SELECT c.first_name, c.last_name, SUM(p.amount) as "Total Amount Paid"
FROM customer AS c
JOIN payment AS p
ON c.customer_id= p.customer_id
GROUP BY c.customer_id 
ORDER BY c.last_name ASC;

-- Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
SELECT title
FROM film 
WHERE title like "K%" OR  title like "Q%"
AND title IN (
	SELECT title
    FROM film as f
    WHERE f.language_id
    IN (
		SELECT l.language_id
        FROM language as l
        WHERE l.name = "English"
));

-- Use subqueries to display all actors who appear in the film Alone Trip.
SELECT first_name, last_name
FROM actor 
WHERE actor_id
IN (
	SELECT actor_id
    FROM film_actor
    WHERE film_id
    IN (
		SELECT film_id
        FROM film
        WHERE title = "Alone Trip"
        )
	);
    
-- Need names and email addresses of all Canadian customers. Use joins to retrieve this information.

SELECT cus.first_name, cus.last_name, cus.email 
FROM customer AS cus
JOIN address AS a 
ON (cus.address_id = a.address_id)
JOIN city AS cty
ON (cty.city_id = a.city_id)
JOIN country AS cou
ON (cou.country_id = cty.country_id)
WHERE cou.country= 'Canada';

-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
-- Identify all movies categorized as family films.
