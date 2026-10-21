DELETE FROM person_visits
WHERE visit_date = '2022-01-08'
  AND person_id = (SELECT id FROM person WHERE name = 'Dmitriy')
  AND pizzeria_id = (SELECT id FROM pizzeria WHERE name = 'DoDo Pizza');

DROP VIEW v_persons_female;
DROP VIEW v_persons_male;
DROP VIEW v_generated_dates;
DROP VIEW v_symmetric_union;
DROP VIEW v_price_with_discount;

DROP MATERIALIZED VIEW mv_dmitriy_visits_and_eats;