--select d.visit_date::date as missing_date from generate_series('2022-01-01'::date, '2022-01-10'::date, '1 day') as d(visit_date) LEFT JOIN person_visits pv ON d.visit_date = pv.visit_date AND ( pv.person_id = 1 OR pv.person_id = 2 ) WHERE pv.visit_date IS NULL ORDER BY missing_date;

--OR
--оба отсутствуют
SELECT d.visit_date::date AS missing_date
FROM generate_series('2022-01-01'::date, '2022-01-10'::date, '1 day') AS d(visit_date)
LEFT JOIN person_visits pv1
  ON d.visit_date = pv1.visit_date AND pv1.person_id = 1
LEFT JOIN person_visits pv2
  ON d.visit_date = pv2.visit_date AND pv2.person_id = 2
WHERE pv1.visit_date IS NULL
  AND pv2.visit_date IS NULL
ORDER BY missing_date;