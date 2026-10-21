# SQL PostgreSQL Practice

10 модулей SQL на PostgreSQL: от выборок и JOIN до индексов, ограничений целостности и уровней изоляции транзакций. Все модули работают на одной учебной БД (сеть пиццерий: клиенты, посещения, меню, заказы).

**Стек:** PostgreSQL 16, psql, SQL (DDL, DML, CTE, window functions, `EXPLAIN ANALYZE`)

## Модули

| # | Модуль | Что сделано | Ключевое |
|---|---|---|---|
| 01 | [select-filtering-subqueries](01-sql-select-filtering-subqueries/) | выборки с фильтрацией, вычисляемые поля, подзапросы | `WHERE`, `BETWEEN`, `CASE`, subquery в `SELECT`/`FROM` |
| 02 | [set-operations-joins](02-sql-set-operations-joins/) | операции над множествами и базовые соединения | `UNION`, `INTERSECT ALL`, `EXCEPT ALL`, `CROSS`/`NATURAL JOIN`, `EXISTS` |
| 03 | [outer-joins-cte](03-sql-outer-joins-cte/) | поиск пропущенных данных, генерация дат, self-join | `LEFT`/`FULL JOIN`, `generate_series`, `WITH` |
| 04 | [dml-insert-update-delete](04-sql-dml-insert-update-delete/) | сложные выборки, затем изменение данных | `INSERT … SELECT`, `UPDATE`, `DELETE` |
| 05 | [views-materialized-views](05-sql-views-materialized-views/) | представления, материализованные представления | `CREATE VIEW`, `MATERIALIZED VIEW`, `REFRESH` |
| 06 | [recursive-cte-tsp](06-sql-recursive-cte-tsp/) | задача коммивояжёра: перебор маршрутов по графу | `WITH RECURSIVE`, arrays |
| 07 | [indexes-query-optimization](07-sql-indexes-query-optimization/) | индексы и анализ планов выполнения | B-Tree, functional, multi-column, unique, partial, `EXPLAIN ANALYZE` |
| 08 | [constraints-sequences](08-sql-constraints-sequences/) | новая таблица с бизнес-логикой скидок | FK, `CHECK`, `NOT NULL`, `COMMENT`, `SEQUENCE`, `ROW_NUMBER()` |
| 09 | [aggregation-analytics](09-sql-aggregation-analytics/) | агрегаты и метрики по пиццериям и клиентам | `GROUP BY`, `HAVING`, `COUNT`/`AVG`/`MIN`/`MAX` |
| 10 | [transactions-isolation-levels](10-sql-transactions-isolation-levels/) | аномалии конкурентного доступа в двух сеансах | `READ COMMITTED`, `REPEATABLE READ`, `SERIALIZABLE`, deadlock |

## Схема БД

Скрипт схемы и данных — учебный материал, в репозиторий не включён. Структура:

| Таблица | Поля | Связи и ограничения |
|---|---|---|
| `person` | `id`, `name`, `age`, `gender`, `address` | `gender IN ('female','male')` |
| `pizzeria` | `id`, `name`, `rating` | `rating BETWEEN 0 AND 5` |
| `menu` | `id`, `pizzeria_id`, `pizza_name`, `price` | FK → `pizzeria` |
| `person_visits` | `id`, `person_id`, `pizzeria_id`, `visit_date` | FK → `person`, `pizzeria`; unique (`person_id`, `pizzeria_id`, `visit_date`) |
| `person_order` | `id`, `person_id`, `menu_id`, `order_date` | FK → `person`, `menu` |

Все `id` — `bigint primary key`.

## Как запустить

```bash
createdb pizza_db
psql -d pizza_db -f <schema_and_data>.sql
psql -d pizza_db -f 01-sql-select-filtering-subqueries/src/ex00/ex00.sql
```

Сброс БД перед повторным прогоном:

```bash
psql -d pizza_db -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"
```

Модуль 10 выполняется в двух параллельных сеансах `psql`; шаги каждого сеанса помечены в файлах комментариями `--Session #1` / `--Session #2`.

## Структура

```
NN-sql-<topic>/
├── README.md        # задача, упражнения, результат
└── src/exNN/exNN.sql
```
