# 08 — Constraints, Comments & Sequences

**Задача:** добавить в схему таблицу персональных скидок: рассчитать скидки по истории заказов, защитить данные ограничениями, задокументировать таблицу и автоматизировать генерацию ключей.
**Стек:** PostgreSQL, psql

## Что сделано
- Спроектировал таблицу `person_discounts` с именованными FK на `person` и `pizzeria`.
- Заполнил её `INSERT … SELECT` с `GROUP BY` и `CASE`: 1 заказ → 10.5%, 2 → 22%, больше → 30%. `id` генерируется через `ROW_NUMBER() OVER ()`.
- Применил скидки к ценам заказов JOIN-ом по паре (`person_id`, `pizzeria_id`).
- Создал уникальный составной индекс, проверил его через `EXPLAIN ANALYZE`.
- Добавил именованные `CHECK`-ограничения (`NOT NULL`, `0 <= discount <= 100`) и `DEFAULT 0`.
- Задокументировал таблицу и все колонки (`COMMENT ON`), проверил через `col_description`.
- Создал `SEQUENCE` для `id`, `setval` синхронизирует её с существующими строками.

## Упражнения

| # | Что делает | Ключевое |
|---|---|---|
| [ex00](src/ex00/ex00.sql) | таблица `person_discounts` | `CREATE TABLE`, `FOREIGN KEY` |
| [ex01](src/ex01/ex01.sql) | расчёт скидок по числу заказов | `INSERT … SELECT`, `GROUP BY`, `CASE`, `ROW_NUMBER()` |
| [ex02](src/ex02/ex02.sql) | цены заказов со скидкой | `JOIN` × 4, `::INT` |
| [ex03](src/ex03/ex03.sql) | `idx_person_discounts_unique` | `UNIQUE INDEX`, `EXPLAIN ANALYZE` |
| [ex04](src/ex04/ex04.sql) | `ch_nn_*`, `ch_range_discount`, `DEFAULT 0` | `ALTER TABLE … ADD CONSTRAINT` |
| [ex05](src/ex05/ex05.sql) | описание таблицы и колонок | `COMMENT ON`, `information_schema` |
| [ex06](src/ex06/ex06.sql) | `seq_person_discounts` как `DEFAULT` для `id` | `CREATE SEQUENCE`, `nextval`, `setval` |

## Как запустить

```bash
psql -d pizza_db -f src/ex00/ex00.sql
```

Запускать по порядку ex00 → ex06: каждый шаг меняет `person_discounts`. Схема БД — в [корневом README](../README.md#схема-бд).

## Результат
- Таблица с бизнес-правилом скидки, ограничениями целостности, комментариями и автоинкрементом.
- Вставка без явного `id` берёт следующий номер из `seq_person_discounts` и не конфликтует с существующими ключами.
