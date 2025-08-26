
WITH all_movies AS
(
	SELECT fc.film_id
	FROM film_category fc
	JOIN 
	(
		SELECT category_id
		FROM category
		WHERE name='Children'
	) c
	ON fc.category_id=c.category_id
),
film_count AS
(
	SELECT actor_id,COUNT(*)
	FROM film_actor fa
	JOIN all_movies am
	ON fa.film_id=am.film_id
	GROUP BY actor_id
)

SELECT * FROM
(
	SELECT first_name,last_name,count,
	DENSE_RANK() OVER (
		ORDER BY COALESCE(count,-1) DESC 
		ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
	)
	FROM actor a
	LEFT JOIN film_count fc
	ON a.actor_id=fc.actor_id
)
WHERE dense_rank<=3
