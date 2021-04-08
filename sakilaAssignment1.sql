/*1st answer Find out the PG-13 rated comedy movies. DO NOT use the film_list table.*/
SELECT
  title
FROM
  category
  INNER JOIN film_category ON film_category.category_id = category.category_id
  INNER JOIN film ON film.film_id = film_category.film_id
WHERE
  rating = 'PG-13'
  AND name = 'Comedy';


  /*2nd answer Find out the top 3 rented horror movies. */
SELECT
  title,
  COUNT(title) AS rental_count
FROM
  film
  INNER JOIN inventory ON inventory.film_id = film.film_id
  INNER JOIN rental ON rental.inventory_id = inventory.inventory_id
  INNER JOIN film_category ON film_category.film_id = film.film_id
  INNER JOIN category ON category.category_id = film_category.category_id
WHERE
  name = 'Horror'
GROUP BY
  title
ORDER BY
  COUNT(title) DESC
LIMIT
  3;


  /*3rd answer Find out the list of customers from India who have rented sports movies.*/
SELECT
  first_name,
  country
FROM
  customer
  INNER JOIN address ON customer.address_id = address.address_id
  INNER JOIN city ON address.city_id = city.city_id
  INNER JOIN country ON country.country_id = city.country_id
WHERE
  country.country = 'India'
  AND customer.customer_id IN (
    SELECT
      customer_id
    FROM
      rental
      INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
      INNER JOIN film_category ON film_category.film_id = inventory.film_id
      INNER JOIN category ON category.category_id = film_category.category_id
    WHERE
      category.name = 'Sports'
  );


  /*4th solution Find out the list of customers from Canada who have rented “NICK WAHLBERG” movies.*/
SELECT
  first_name,
  country
FROM
  customer c
  INNER JOIN address ON c.address_id = address.address_id
  INNER JOIN city ON address.city_id = city.city_id
  INNER JOIN country ON country.country_id = city.country_id
WHERE
  country.country = 'Canada'
  AND c.customer_id IN (
    SELECT
      customer_id
    FROM
      rental r
      INNER JOIN inventory i ON i.inventory_id = r.inventory_id
      INNER JOIN film_actor fa ON fa.film_id = i.film_id
      INNER JOIN actor a ON a.actor_id = fa.actor_id
    WHERE
      a.first_name = 'NICK'
      AND a.last_name = 'WAHLBERG'
  );

  
  /*5th solution Find out the number of movies in which “SEAN WILLIAMS” acted.*/
SELECT
  COUNT(title) AS number_of_movies
FROM
  film
  INNER JOIN film_actor ON film_actor.film_id = film.film_id
  INNER JOIN actor ON actor.actor_id = film_actor.actor_id
WHERE
  first_name = 'SEAN'
  AND last_name = 'WILLIAMS';