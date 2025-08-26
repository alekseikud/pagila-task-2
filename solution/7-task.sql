WITH film_time AS
(
	SELECT r.customer_id,c.name   AS category,
	(r.return_date-r.rental_date) AS time
	FROM rental r
	JOIN inventory i      ON i.inventory_id=r.inventory_id
	JOIN film_category fc ON fc.film_id=i.film_id
	JOIN category c 	  ON c.category_id=fc.category_id
),
city_category_time AS
(
	SELECT ci.city,ft.category,SUM(ft.time) AS time
	FROM film_time ft 
	JOIN customer c ON ft.customer_id=c.customer_id
	JOIN address a	ON a.address_id=c.address_id
	JOIN city ci	ON ci.city_id=a.city_id
	GROUP BY ci.city,ft.category
),
city_category_max_time AS
(
	SELECT 
	(
		CASE 
			WHEN city ~ '^A' THEN 'A'
 			WHEN city ~ '-' THEN '-'
		END
	) AS city_type,category,time
	FROM city_category_time
),
ranked AS
(
	SELECT city_type,category,time,RANK() OVER (PARTITION BY city_type ORDER BY time DESC)
	FROM
	(
		SELECT city_type,category,SUM(time) AS time
		FROM city_category_max_time
		GROUP BY city_type,category
	)
)
SELECT city_type,category,time
FROM ranked
WHERE rank=1 AND city_type ~ '^A|-'
