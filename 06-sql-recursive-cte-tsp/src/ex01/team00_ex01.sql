WITH RECURSIVE paths AS (
    SELECT
        point1,
        point2,
        cost,
        ARRAY[point1::text, point2::text] AS tour
    FROM routes
    WHERE point1 = 'a'

    UNION ALL

    SELECT
        p.point1,
        r.point2,
        p.cost + r.cost,
        p.tour || r.point2::text
    FROM paths p
    JOIN routes r ON p.point2 = r.point1
    WHERE r.point2 <> ALL(p.tour)
),

final_paths AS (
    SELECT
        p.cost + r.cost AS total_cost,
        p.tour || r.point2 AS tour
    FROM paths p
    JOIN routes r ON p.point2 = r.point1
    WHERE
        r.point2 = 'a'
        AND array_length(p.tour, 1) = 4
)

SELECT total_cost, tour
FROM final_paths
WHERE total_cost = (SELECT MIN(total_cost) FROM final_paths)

UNION ALL

SELECT total_cost, tour
FROM final_paths
WHERE total_cost = (SELECT MAX(total_cost) FROM final_paths)

ORDER BY total_cost, tour;