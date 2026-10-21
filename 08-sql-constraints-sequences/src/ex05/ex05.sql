
COMMENT ON TABLE person_discounts IS NULL;
COMMENT ON COLUMN person_discounts.id IS NULL;
COMMENT ON COLUMN person_discounts.person_id IS NULL;
COMMENT ON COLUMN person_discounts.pizzeria_id IS NULL;
COMMENT ON COLUMN person_discounts.discount IS NULL;

COMMENT ON TABLE person_discounts IS 
'Table storing personal discount rates for each person in each pizzeria';

COMMENT ON COLUMN person_discounts.id IS 
'Primary key of the table';

COMMENT ON COLUMN person_discounts.person_id IS 
'Reference to the person who receives the discount';

COMMENT ON COLUMN person_discounts.pizzeria_id IS 
'Reference to the pizzeria where the discount is applied';

COMMENT ON COLUMN person_discounts.discount IS 
'Discount percentage for a person in a specific pizzeria';


SELECT 
    c.column_name,
    col_description(
        ('person_discounts')::regclass, 
        c.ordinal_position
    ) AS comment
FROM information_schema.columns c
WHERE c.table_name = 'person_discounts';