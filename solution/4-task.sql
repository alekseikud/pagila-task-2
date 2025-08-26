SELECT title
FROM inventory
RIGHT JOIN film
USING(film_id)
WHERE inventory.film_id is NULL
GROUP BY film_id,title


