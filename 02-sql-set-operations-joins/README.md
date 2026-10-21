# 02 — Set Operations & Joins

**Задача:** объединить, пересечь и вычесть наборы данных из разных таблиц, затем связать таблицы соединениями.
**Стек:** PostgreSQL, psql

## Что сделано
- Операции над множествами с дубликатами и без: `UNION` / `UNION ALL`, `INTERSECT` / `INTERSECT ALL`, `EXCEPT ALL`.
- Уникальные значения без `DISTINCT`/`GROUP BY` — через `INTERSECT` или `UNION` таблицы с самой собой (ex02).
- Соединения: `CROSS JOIN`, `INNER JOIN` по трём таблицам, `NATURAL JOIN` с переименованием колонки в подзапросе.
- Антисоединение двумя способами: `NOT IN` и `NOT EXISTS` (ex09).

## Упражнения

| # | Что делает | Ключевое |
|---|---|---|
| [ex00](src/ex00/ex00.sql) | `id` + название из `menu` и `person` одним списком | `UNION` |
| [ex01](src/ex01/ex01.sql) | имена: сначала `person`, потом `menu`, с дубликатами | `UNION ALL`, служебная колонка сортировки |
| [ex02](src/ex02/ex02.sql) | уникальные названия пицц без `DISTINCT` | `INTERSECT` / `UNION` |
| [ex03](src/ex03/ex03.sql) | дни, когда клиент и заказывал, и посещал | `INTERSECT ALL` |
| [ex04](src/ex04/ex04.sql) | заказы 07.01.2022 без визита в тот же день | `EXCEPT ALL` |
| [ex05](src/ex05/ex05.sql) | все комбинации клиент × пиццерия | `CROSS JOIN` |
| [ex06](src/ex06/ex06.sql) | то же, что ex03, но с именами | `INTERSECT` + подзапрос |
| [ex07](src/ex07/ex07.sql) | дата заказа + `Name (age:X)` | `INNER JOIN` |
| [ex08](src/ex08/ex08.sql) | ex07 через `NATURAL JOIN` | `NATURAL JOIN` |
| [ex09](src/ex09/ex09.sql) | пиццерии без посещений | `NOT IN` vs `NOT EXISTS` |
| [ex10](src/ex10/ex10.sql) | клиент, пицца, пиццерия по всем заказам | `INNER JOIN` × 3 |

## Как запустить

```bash
psql -d pizza_db -f src/ex00/ex00.sql
```

Схема БД — в [корневом README](../README.md#схема-бд).

## Результат
- 11 запросов; для ex01, ex02 и ex09 есть по два эквивалентных решения в одном файле.
- Одна выборка (ex07/ex08) реализована через `INNER JOIN` и `NATURAL JOIN` с одинаковым результатом.
