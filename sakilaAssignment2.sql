/* 1st solution Find out the number of documentaries WITH deleted scenes. */
SELECT
  title
FROM
  film
WHERE
  special_features LIKE '%Deleted Scenes%'
  AND film_id IN (
    SELECT
      film.film_id
    FROM
      film
      INNER JOIN film_category fc ON fc.film_id = film.film_id
      INNER JOIN category c ON c.category_id = fc.category_id
    WHERE
      name = 'Documentary'
  );


  /* 2nd solution Find out the number of sci-fi movies rented by the store managed by Jon Stephens. */
SELECT
  COUNT(title) AS number_of_sci_fi_movies_rented_by_the_store_managed_by_Jon_Stephen
FROM
  film
  INNER JOIN film_category fc ON fc.film_id = film.film_id
  INNER JOIN category ON fc.category_id = category.category_id
WHERE
  category.name = 'Sci-Fi'
  AND film.film_id IN (
    SELECT
      film_id
    FROM
      rental
      INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
      INNER JOIN store ON store.store_id = inventory.store_id
      INNER JOIN staff ON staff.staff_id = store.manager_staff_id
    WHERE
      staff.first_name = 'Jon'
      AND staff.last_name = 'Stephens'
  );


  /* 3rd solution Find out the total sales FROM Animation movies. */
SELECT
  total_sales AS total_sales_from_Animation_movies
FROM
  sales_by_film_category
WHERE
  sales_by_film_category.category = 'Animation';


  /* 4th solution Find out the top 3 rented category of movies by “PATRICIA JOHNSON”. */
SELECT
  category.name
FROM
  rental
  INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
  INNER JOIN film_category ON film_category.film_id = inventory.film_id
  INNER JOIN category ON category.category_id = film_category.category_id
WHERE
  rental.inventory_id IN (
    SELECT
      inventory_id
    FROM
      inventory
      INNER JOIN film_actor ON film_actor.film_id = inventory.film_id
      INNER JOIN actor ON actor.actor_id = film_actor.actor_id
    WHERE
      actor.first_name = 'PATRICIA'
      AND actor.last_name = 'JOHNSON'
  )
GROUP BY
  category.name
ORDER BY
  count(category.name) DESC
LIMIT
  3;

  
  /* 5th solution Find out the number of R rated movies rented by “SUSAN WILSON” */
SELECT
  count(*) AS number_of_R_rated_movies_rented_by_SUSAN_WILSON
FROM
  film
  INNER JOIN film_actor ON film.film_id = film_actor.film_id
  INNER JOIN actor ON actor.actor_id = film_actor.actor_id
WHERE
  actor.first_name = 'SUSAN'
  AND actor.last_name = 'WILSON'
  AND film.rating = 'R';