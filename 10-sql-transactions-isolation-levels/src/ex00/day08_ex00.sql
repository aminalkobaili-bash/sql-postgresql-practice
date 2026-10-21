--Session #1
BEGIN;

UPDATE pizzeria
SET rating = 5
WHERE name = 'Pizza Hut';

SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

COMMIT;

--Session #2
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';



-- to kill transaction 
-- SELECT pid, state, query, age(clock_timestamp(), query_start) 
-- FROM pg_stat_activity 
-- WHERE state != 'idle'
-- ORDER BY age(clock_timestamp(), query_start) DESC;

-- SELECT pg_cancel_backend(PID);