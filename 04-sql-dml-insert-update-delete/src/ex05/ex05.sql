SELECT pz.name AS pizzeria_name
FROM pizzeria pz
WHERE pz.id IN (
    -- куда ходил Andrey
    SELECT pv.pizzeria_id
    FROM person_visits pv
    JOIN person p ON pv.person_id = p.id
    WHERE p.name = 'Andrey'

    EXCEPT

    -- где он делал заказы
    SELECT m.pizzeria_id
    FROM person_order po
    JOIN person p ON po.person_id = p.id
    JOIN menu m ON po.menu_id = m.id
    WHERE p.name = 'Andrey'
)
ORDER BY pizzeria_name;