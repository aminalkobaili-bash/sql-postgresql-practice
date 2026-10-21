select name from pizzeria WHERE id NOT IN (select pizzeria_id from person_visits);

-- or

select name from pizzeria p WHERE NOT EXISTS (select pizzeria_id from person_visits WHERE pizzeria_id = p.id);