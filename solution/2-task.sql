WITH film_actor_data AS
(
	SELECT f.film_id,a.actor_id,a.first_name,a.last_name
	FROM film_actor fa
	JOIN film f
	ON fa.film_id=f.film_id
	JOIN actor a
	ON a.actor_id=fa.actor_id
),
film_rental_rate AS
(
	SELECT i.film_id,COUNT(*)
	FROM rental r 
	JOIN inventory i
	ON r.inventory_id=i.inventory_id
	GROUP BY film_id
)

SELECT * FROM
(
	SELECT actor_id ,first_name,last_name,SUM(count)
	FROM film_actor_data
	JOIN film_rental_rate
	ON film_actor_data.film_id=film_rental_rate.film_id
	GROUP BY actor_id ,first_name,last_name
)
ORDER BY SUM DESC
LIMIT 10
