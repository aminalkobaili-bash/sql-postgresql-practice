INSERT INTO menu (id, pizzeria_id, pizza_name, price)
VALUES (
    (SELECT MAX(id) + 1 FROM menu),
    (SELECT id FROM pizzeria WHERE name = 'Dominos'),
    'sicilian pizza',
    900
);


-- TO DELETE

-- DELETE FROM menu 
-- WHERE pizza_name = 'sicilian pizza' 
--   AND pizzeria_id = (SELECT id FROM pizzeria WHERE name = 'Dominos');
