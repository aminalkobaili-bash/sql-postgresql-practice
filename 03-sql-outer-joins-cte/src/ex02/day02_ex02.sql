select 
  COALESCE(p.name, '-') as person_name,
  pv.visit_date,
  COALESCE(pi.name, '-') as pizzeria_name
from person p
FULL JOIN (
    select *
    FROM person_visits
    WHERE visit_date BETWEEN '2022-01-01' AND '2022-01-03'
) pv
  ON p.id = pv.person_id
FULL JOIN pizzeria pi
  ON pi.id = pv.pizzeria_id
ORDER BY person_name, pv.visit_date, pizzeria_name;