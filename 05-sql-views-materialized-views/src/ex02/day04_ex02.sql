CREATE VIEW v_generated_dates AS
SELECT gs::date AS generated_date
FROM generate_series('2022-01-01'::date, '2022-01-31'::date, '1 day') AS gs
ORDER BY generated_date;


-- TO DELETE

-- DROP VIEW v_generated_dates;