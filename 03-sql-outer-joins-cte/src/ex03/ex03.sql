WITH d AS (
    SELECT d.visit_date::date AS missing_date
    FROM generate_series('2022-01-01'::date, '2022-01-10'::date, '1 day') AS d(visit_date)
    LEFT JOIN person_visits pv1
    ON d.visit_date = pv1.visit_date AND pv1.person_id = 1
    LEFT JOIN person_visits pv2
    ON d.visit_date = pv2.visit_date AND pv2.person_id = 2
    WHERE pv1.visit_date IS NULL
    AND pv2.visit_date IS NULL
)
select * from d ORDER BY missing_date;