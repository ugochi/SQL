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