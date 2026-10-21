# 03 — Outer Joins & CTE

**Задача:** найти отсутствующие данные (пропущенные даты, пиццерии без посещений) и собрать выборки по нескольким связанным таблицам.
**Стек:** PostgreSQL, psql

## Что сделано
- Поиск «дыр» в данных через `LEFT JOIN … WHERE … IS NULL` вместо `IN`/`EXISTS`/операций над множествами.
- Генерация календаря `generate_series` и поиск дат без визитов.
- `FULL JOIN` трёх таблиц с заменой `NULL` на `'-'` через `COALESCE`.
- Тот же запрос переписан через CTE `WITH` (ex01 → ex03).
- Многотабличные JOIN с фильтрами, двойное соединение одной таблицы (ex09) и self-join (ex10).

## Упражнения

| # | Что делает | Ключевое |
|---|---|---|
| [ex00](src/ex00/ex00.sql) | пиццерии без посещений | `LEFT JOIN` + `IS NULL` |
| [ex01](src/ex01/ex01.sql) | даты 01–10.01.2022 без визитов клиентов 1 и 2 | `generate_series`, `LEFT JOIN` |
| [ex02](src/ex02/ex02.sql) | клиенты и пиццерии за 01–03.01.2022, включая без пары | `FULL JOIN`, `COALESCE` |
| [ex03](src/ex03/ex03.sql) | ex01 через CTE | `WITH` |
| [ex04](src/ex04/ex04.sql) | пиццы с pepperoni/mushroom, пиццерия, цена | `JOIN`, `LIKE` |
| [ex05](src/ex05/ex05.sql) | женщины старше 25 | `WHERE` |
| [ex06](src/ex06/ex06.sql) | пиццы и пиццерии из заказов Anna и Denis | `JOIN` × 3 |
| [ex07](src/ex07/ex07.sql) | пиццерия Dmitriy 08.01.2022 с ценой < 800 | `JOIN` × 3 |
| [ex08](src/ex08/ex08.sql) | мужчины из Moscow/Samara с заказами pepperoni/mushroom | `JOIN`, `IN`, `DISTINCT` |
| [ex09](src/ex09/ex09.sql) | женщины, заказавшие и cheese, и pepperoni | двойной `JOIN` одной таблицы |
| [ex10](src/ex10/ex10.sql) | пары клиентов с одинаковым адресом | self-join, `p1.id > p2.id` |

## Как запустить

```bash
psql -d pizza_db -f src/ex00/ex00.sql
```

Схема БД — в [корневом README](../README.md#схема-бд).

## Результат
- 11 запросов; поиск пропусков решён без `IN`/`EXISTS`/`EXCEPT`, только outer join.
- Повтор пар в self-join исключён условием `p1.id > p2.id`.
