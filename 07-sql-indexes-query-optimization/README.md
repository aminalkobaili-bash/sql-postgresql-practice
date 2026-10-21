# 07 — Indexes & Query Optimization

**Задача:** ускорить запросы к БД заказов индексами и подтвердить, что планировщик их использует.
**Стек:** PostgreSQL, psql, B-Tree, `EXPLAIN ANALYZE`

## Что сделано
- Создал B-Tree индексы на все 5 FK-колонок по схеме `idx_<table>_<column>`.
- Построил функциональный индекс по `UPPER(name)` для регистронезависимого поиска.
- Добавил составной индекс `(person_id, menu_id, order_date)` под запрос, который читает только эти колонки.
- Создал уникальный индекс `(pizzeria_id, pizza_name)` и partial unique индекс `WHERE order_date = '2022-01-01'`.
- Подобрал индекс под запрос с window function (ex06).
- Каждый план проверен через `EXPLAIN ANALYZE` с `SET enable_seqscan = off`.
- Все скрипты идемпотентны: `DROP INDEX IF EXISTS` перед `CREATE`.

## Упражнения

| # | Что делает | Ключевое |
|---|---|---|
| [ex00](src/ex00/ex00.sql) | индексы на FK `menu`, `person_order`, `person_visits` | `CREATE INDEX` |
| [ex01](src/ex01/ex01.sql) | план JOIN `menu` × `pizzeria` | `EXPLAIN ANALYZE` |
| [ex02](src/ex02/ex02.sql) | `idx_person_name` по `UPPER(name)` | functional index |
| [ex03](src/ex03/ex03.sql) | `idx_person_order_multi (person_id, menu_id, order_date)` | multi-column, Index Only Scan |
| [ex04](src/ex04/ex04.sql) | `idx_menu_unique (pizzeria_id, pizza_name)` | `UNIQUE INDEX` |
| [ex05](src/ex05/ex05.sql) | `idx_person_order_order_date` только для `2022-01-01` | partial unique index |
| [ex06](src/ex06/ex06.sql) | `idx_1 (id, rating)` под запрос с `max() OVER (PARTITION BY …)` | tuning window query |

## Как запустить

```bash
psql -d pizza_db -f src/ex00/ex00.sql
psql -d pizza_db -f src/ex01/ex01.sql
```

ex01 использует индексы из ex00. Остальные файлы самодостаточны. Схема БД — в [корневом README](../README.md#схема-бд).

## Результат
- 10 индексов пяти типов: B-Tree, functional, multi-column, unique, partial.
- Каждый запрос использует созданный для него индекс (при `enable_seqscan = off`).

### Замеры

PostgreSQL 16.13, локально; учебные данные: 9 person, 6 pizzeria, 18 menu, 19 person_visits, 20 person_order. Execution Time — медиана 7 прогонов `EXPLAIN ANALYZE`.

| # | Узел плана | Execution Time, ms |
|---|---|---|
| ex01 | Index Scan using `idx_menu_pizzeria_id` + `pizzeria_pkey` | 0.117 |
| ex02 | Index Scan using `idx_person_name` | 0.048 |
| ex03 | Index Only Scan using `idx_person_order_multi` | 0.072 |
| ex04 | Index Scan using `idx_menu_unique` | 0.074 |
| ex05 | Index Only Scan using `idx_person_order_order_date` | 0.105 |

ex06 — запрос с window function, до и после `idx_1`:

| Вариант | Узлы плана | Execution Time, ms |
|---|---|---|
| планировщик по умолчанию, без `idx_1` | Seq Scan `menu` + Seq Scan `pizzeria` | 0.188 |
| `enable_seqscan = off`, без `idx_1` | Index Only Scan `idx_menu_unique` + Index Scan `pizzeria_pkey` | 0.242 |
| `enable_seqscan = off`, с `idx_1` | Index Only Scan `idx_menu_unique` + Index Only Scan `idx_1` | 0.275 |

**Вывод:** `idx_1` переводит чтение `pizzeria` на Index Only Scan, но ускорения нет — разница в пределах погрешности. На таблицах из 6–20 строк Seq Scan дешевле любого индекса, поэтому планировщик выбирает его, если не отключить `enable_seqscan`. Выигрыш от индексов проявится на объёмах, где таблица не помещается в несколько страниц.
