# 05 — Views & Materialized Views

**Задача:** вынести повторяющиеся выборки в представления, сохранить результат запроса в материализованное представление и обновить его после изменения данных.
**Стек:** PostgreSQL, psql

## Что сделано
- Создал 5 представлений (`CREATE VIEW`): фильтры по полу, календарь дат, симметрическая разность, цена со скидкой.
- Календарь января 2022 через `generate_series` и поиск дат без визитов (`EXCEPT`).
- Симметрическая разность `(R − S) ∪ (S − R)` на `EXCEPT` + `UNION`.
- `MATERIALIZED VIEW` с условием `EXISTS`, после `INSERT` — `REFRESH MATERIALIZED VIEW`.
- Очистка: удаление тестового визита и всех созданных объектов (ex08).

## Упражнения

| # | Что делает | Ключевое |
|---|---|---|
| [ex00](src/ex00/ex00.sql) | `v_persons_female`, `v_persons_male` | `CREATE VIEW` |
| [ex01](src/ex01/ex01.sql) | все имена из двух представлений | `UNION ALL` |
| [ex02](src/ex02/ex02.sql) | `v_generated_dates`: 01–31.01.2022 | `generate_series`, `::date` |
| [ex03](src/ex03/ex03.sql) | даты без визитов | `EXCEPT` по view |
| [ex04](src/ex04/ex04.sql) | `v_symmetric_union`: визиты 02.01 vs 06.01 | `EXCEPT` + `UNION` |
| [ex05](src/ex05/ex05.sql) | `v_price_with_discount`: цена −10% | вычисляемое поле, `::integer` |
| [ex06](src/ex06/ex06.sql) | `mv_dmitriy_visits_and_eats` | `MATERIALIZED VIEW`, `EXISTS` |
| [ex07](src/ex07/ex07.sql) | новый визит Dmitriy + обновление MV | `INSERT … SELECT`, `REFRESH` |
| [ex08](src/ex08/ex08.sql) | откат визита, удаление всех view и MV | `DELETE`, `DROP VIEW` |

## Как запустить

```bash
psql -d pizza_db -f src/ex00/ex00.sql
```

Файлы зависят друг от друга (ex01 и ex03 читают созданные ранее view): запускать по порядку ex00 → ex08. Схема БД — в [корневом README](../README.md#схема-бд).

## Результат
- 5 представлений и 1 материализованное представление, полный цикл create → use → refresh → drop.
- После ex08 БД возвращается в исходное состояние.
