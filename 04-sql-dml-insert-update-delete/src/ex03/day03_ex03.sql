SELECT DISTINCT pz.name AS pizzeria_name
FROM (
    (
        SELECT pv.pizzeria_id
        FROM person_visits pv
        JOIN person p ON pv.person_id = p.id
        WHERE p.gender = 'female'

        EXCEPT ALL

        SELECT pv.pizzeria_id
        FROM person_visits pv
        JOIN person p ON pv.person_id = p.id
        WHERE p.gender = 'male'
    )

    UNION ALL

    (
        SELECT pv.pizzeria_id
        FROM person_visits pv
        JOIN person p ON pv.person_id = p.id
        WHERE p.gender = 'male'

        EXCEPT ALL

        SELECT pv.pizzeria_id
        FROM person_visits pv
        JOIN person p ON pv.person_id = p.id
        WHERE p.gender = 'female'
    )
) t
JOIN pizzeria pz ON t.pizzeria_id = pz.id
ORDER BY pizzeria_name;