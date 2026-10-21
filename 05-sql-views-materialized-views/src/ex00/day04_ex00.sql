CREATE VIEW v_persons_female AS
SELECT *
FROM person
WHERE gender = 'female';

CREATE VIEW v_persons_male AS
SELECT *
FROM person
WHERE gender = 'male';

-- TO DELETE

-- DROP VIEW v_persons_female, v_persons_male;