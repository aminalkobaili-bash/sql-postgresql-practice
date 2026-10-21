SELECT m.pizza_name, p.name AS pizzeria_name, m.price
FROM menu m
INNER JOIN pizzeria p ON m.pizzeria_id = p.id
WHERE m.pizza_name LIKE '%pepperoni%'
   OR m.pizza_name LIKE '%mushroom%'
ORDER BY m.pizza_name, p.name;