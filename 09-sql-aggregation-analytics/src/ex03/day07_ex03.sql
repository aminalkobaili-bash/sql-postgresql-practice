SELECT 
    COALESCE(v.name, o.name) AS name,
    COALESCE(v.visit_count, 0) + COALESCE(o.order_count, 0) AS total_count
FROM (
    SELECT pz.name, COUNT(*) AS visit_count
    FROM pizzeria pz
    JOIN person_visits pv ON pz.id = pv.pizzeria_id
    GROUP BY pz.name
) v
FULL JOIN (
    SELECT pz.name, COUNT(*) AS order_count
    FROM pizzeria pz
    JOIN menu m ON pz.id = m.pizzeria_id
    JOIN person_order po ON m.id = po.menu_id
    GROUP BY pz.name
) o
ON v.name = o.name
ORDER BY total_count DESC, name ASC;


-- SELECT name, SUM(count) AS total_count
-- FROM (
--     SELECT pz.name, COUNT(*) AS count
--     FROM pizzeria pz
--     JOIN person_visits pv ON pz.id = pv.pizzeria_id
--     GROUP BY pz.name

--     UNION ALL

--     SELECT pz.name, COUNT(*) AS count
--     FROM pizzeria pz
--     JOIN menu m ON pz.id = m.pizzeria_id
--     JOIN person_order po ON m.id = po.menu_id
--     GROUP BY pz.name
-- ) t
-- GROUP BY name
-- ORDER BY total_count DESC, name ASC;