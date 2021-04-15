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
  COUNT(*)
FROM
  category c,
  film_category fc,
  inventory i,
  rental r,
  staff s
WHERE
  c.name = 'Sci-fi'
  AND c.category_id = fc.category_id
  AND fc.film_id = i.film_id
  AND i.inventory_id = r.inventory_id
  AND r.staff_id = s.staff_id
  AND s.first_name = 'Jon'
  AND s.last_name = 'Stephens';






  /* 3rd solution Find out the total sales FROM Animation movies. */
SELECT
  total_sales AS total_sales_from_Animation_movies
FROM
  sales_by_film_category
WHERE
  sales_by_film_category.category = 'Animation';





  /* 4th solution Find out the top 3 rented category of movies by “PATRICIA JOHNSON”. */
SELECT
  fl.category
FROM
  film_list fl
WHERE
  fl.FID IN (
    SELECT
      i.film_id
    FROM
      rental r,
      customer_list cl,
      inventory i
    where
      cl.name = 'PATRICIA JOHNSON'
      AND cl.ID = r.customer_id
      AND r.inventory_id = i.inventory_id
  )
GROUP BY
  fl.category
ORDER BY
  count(all fl.category) desc,
  fl.category
limit
  3;





  
  /* 5th solution Find out the number of R rated movies rented by “SUSAN WILSON” */
SELECT
  COUNT(*) as number_of_R_rated_movies_rented_by_SUSAN_WILSON
FROM
  film_list f,
  rental r,
  inventory i,
  customer_list c
WHERE
  f.rating = 'R'
  AND f.FID = i.film_id
  AND i.inventory_id = r.inventory_id
  AND r.customer_id = c.ID
  AND c.name = 'SUSAN WILSON';