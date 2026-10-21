# 10 — Transactions & Isolation Levels

**Задача:** воспроизвести аномалии конкурентного доступа (lost update, non-repeatable read, phantom read, deadlock) в двух параллельных сеансах и показать, какой уровень изоляции PostgreSQL их предотвращает.
**Стек:** PostgreSQL, psql (2 сеанса), `BEGIN`/`COMMIT`, `READ COMMITTED`, `REPEATABLE READ`, `SERIALIZABLE`

## Что сделано
- Проверил видимость незафиксированных изменений между сеансами.
- Воспроизвёл каждую аномалию на `READ COMMITTED`, затем повторил сценарий на более строгом уровне.
- Получил deadlock встречными `UPDATE` двух строк в разном порядке.
- Каждый шаг зафиксирован скриншотами обоих сеансов (`screenshots/session-1.jpg`, `session-2.jpg`).
- В ex00 есть запрос к `pg_stat_activity` и `pg_cancel_backend()` для поиска и отмены зависшей транзакции.

## Упражнения

| # | Сценарий | Уровень | Что наблюдается |
|---|---|---|---|
| [ex00](src/ex00/ex00.sql) | `UPDATE` в сеансе 1, чтение в сеансе 2 | default | изменение видно сеансу 2 только после `COMMIT` |
| [ex01](src/ex01/ex01.sql) | lost update | `READ COMMITTED` | второй `UPDATE` ждёт блокировку и перезаписывает первый: итог 3.6, значение 4 потеряно |
| [ex02](src/ex02/ex02.sql) | lost update | `REPEATABLE READ` | `ERROR: could not serialize access due to concurrent update`, откат второй транзакции |
| [ex03](src/ex03/ex03.sql) | non-repeatable read | `READ COMMITTED` | повторный `SELECT` в той же транзакции видит новое значение |
| [ex04](src/ex04/ex04.sql) | non-repeatable read | `SERIALIZABLE` | оба `SELECT` возвращают 3.6; новое значение 3.0 видно только после `COMMIT` |
| [ex05](src/ex05/ex05.sql) | phantom read (`SUM` + `INSERT`) | `READ COMMITTED` | сумма меняется внутри транзакции |
| [ex06](src/ex06/ex06.sql) | phantom read (`SUM` + `INSERT`) | `REPEATABLE READ` | `SUM` = 26.9 оба раза, после `COMMIT` — 30.9 |
| [ex07](src/ex07/ex07.sql) | встречные `UPDATE` id 1 и 2 | default | `ERROR: deadlock detected`, PostgreSQL откатывает одну транзакцию |

Скриншоты лежат в `src/exNN/screenshots/`.

## Как запустить

Открыть два терминала:

```bash
psql -d pizza_db
```

Выполнять команды из блоков `--Session #1` и `--Session #2` поочерёдно, построчно, в порядке сценария. Схема БД — в [корневом README](../README.md#схема-бд).

## Результат
- 4 типа аномалий воспроизведены и сопоставлены с уровнями изоляции.
- Подтверждено: в PostgreSQL `REPEATABLE READ` защищает от lost update (ошибкой сериализации) и от phantom read.
- Deadlock обнаруживается СУБД автоматически; одна транзакция завершается `ROLLBACK`.
