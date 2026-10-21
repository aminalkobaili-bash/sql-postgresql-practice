select object_name from ( select pizza_name as object_name, 1 as sort_order from menu UNION ALL select name as object_name, 2 as sort_order from person ) t ORDER BY sort_order DESC, object_name;

-- or

select object_name from ( select name as object_name, 1 as sort_order from person UNION ALL select pizza_name as object_name, 2 as sort_order from menu ) t ORDER BY sort_order, object_name;