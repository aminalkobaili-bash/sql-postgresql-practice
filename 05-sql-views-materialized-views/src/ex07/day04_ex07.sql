INSERT INTO person_visits (id, person_id, pizzeria_id, visit_date)
SELECT 
    (SELECT MAX(id) + 1 FROM person_visits),
    p.id,
    pz.id,
    '2022-01-08'
FROM person p
JOIN pizzeria pz ON pz.name = 'DoDo Pizza'
WHERE p.name = 'Dmitriy';

REFRESH MATERIALIZED VIEW mv_dmitriy_visits_and_eats;