WITH category_counts AS
(
	SELECT category_id,COUNT(*)
	FROM film_category
	GROUP BY category_id
)

SELECT c.name AS category,cc.category_id,
cc.count AS number
FROM category_counts cc
JOIN category c
ON cc.category_id=c.category_id
ORDER BY number DESC

-- --OR

-- SELECT c.name AS category,cc.category_id,
-- cc.count AS number
-- FROM 
-- (
-- 	SELECT category_id,COUNT(*)
-- 	FROM film_category
-- 	GROUP BY category_id
-- ) cc
-- JOIN category c
-- ON cc.category_id=c.category_id
-- ORDER BY number DESC
