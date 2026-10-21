SELECT pz.name AS pizzeria_name
FROM pizzeria pz
WHERE pz.id IN (
    (
        SELECT m.pizzeria_id
        FROM person_order po
        JOIN person p ON po.person_id = p.id
        JOIN menu m ON po.menu_id = m.id
        WHERE p.gender = 'female'

        EXCEPT

        SELECT m.pizzeria_id
        FROM person_order po
        JOIN person p ON po.person_id = p.id
        JOIN menu m ON po.menu_id = m.id
        WHERE p.gender = 'male'
    )

    UNION

    (
        SELECT m.pizzeria_id
        FROM person_order po
        JOIN person p ON po.person_id = p.id
        JOIN menu m ON po.menu_id = m.id
        WHERE p.gender = 'male'

        EXCEPT

        SELECT m.pizzeria_id
        FROM person_order po
        JOIN person p ON po.person_id = p.id
        JOIN menu m ON po.menu_id = m.id
        WHERE p.gender = 'female'
    )
)
ORDER BY pizzeria_name;