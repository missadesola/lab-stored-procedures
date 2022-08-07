-- Convert the query into a simple stored procedure?
select first_name, last_name, email
from customer
join rental on customer.customer_id = rental.customer_id
join inventory on rental.inventory_id = inventory.inventory_id
join film on film.film_id = inventory.film_id
join film_category on film_category.film_id = film.film_id
join category on category.category_id = film_category.category_id
where category.name = "Action"
group by first_name, last_name, email;

-- Update the stored procedure in a such manner that it can take a string argument for the category name and return the results for all customers that rented movie of that category/genre.

DELIMITER //
CREATE PROCEDURE customer_detail(IN categories char(20))
BEGIN
SELECT first_name, last_name, email
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON film.film_id = inventory.film_id
JOIN film_category ON film_category.film_id = film.film_id
JOIN category ON category.category_id = film_category.category_id
WHERE category.name = categories
GROUP BY first_name, last_name, email;
END //
DELIMITER ;
        
CALL customer_detail('Animation');

-- Write a query to check the number of movies released in each movie category.
-- Convert the query in to a stored procedure to filter only those categories that have movies released greater than a certain number.
-- Pass that number as an argument in the stored procedure.

DELIMITER //
CREATE PROCEDURE num_movies(IN number int)
BEGIN
SELECT category.name, COUNT(film.film_id)
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
HAVING COUNT(film.film_id) > number;
END //
DELIMITER ;

CALL num_movies(60);
