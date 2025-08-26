SELECT city,active,inactive
FROM(
	SELECT city_id,
	COUNT(
		CASE
		WHEN active=1 THEN 1
		END
	) AS active,
	COUNT(
		CASE
		WHEN active=0 THEN 1
		END
	) AS inactive
	FROM customer
	JOIN address 
	USING(address_id)
	GROUP BY city_id
)
JOIN city
USING(city_id)
ORDER BY inactive DESC
