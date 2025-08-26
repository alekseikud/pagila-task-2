SELECT category_name FROM
(
	SELECT fc.category_id,c.name AS category_name,
	SUM(p.amount) AS money_spent
	FROM payment p
	JOIN rental r
	ON r.rental_id=p.rental_id
	JOIN inventory i
	ON i.inventory_id=r.inventory_id
	JOIN film_category fc
	ON i.film_id=fc.film_id
	JOIN category c
	ON c.category_id=fc.category_id
	GROUP BY fc.category_id,c.name
)
ORDER BY money_spent DESC
LIMIT 1
