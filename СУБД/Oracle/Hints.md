# Hints Oracle

- [Hints Oracle](https://iusoltsev.wordpress.com/profile/individual-sql-and-cbo/cbo-hints/)

В Oracle существуют различные подсказки (hints), которые можно использовать для управления оптимизацией 
запросов и выбора плана выполнения. Вот некоторые из наиболее популярных и часто используемых подсказок:

/*+ ALL_ROWS */

1. **Подсказки для выбора метода соединения**:
   - `USE_NL`: Использовать соединение по принципу "nested loop".
   - `USE_HASH`: Использовать хеш-метод соединения.
   - `USE_MERGE`: Использовать метод объединения (merge join).

2. **Подсказки для управления порядком выполнения операций**:
   - `ORDERED`: Выполнять операции в том порядке, в каком они указаны в запросе.
   - `FIRST_ROWS(n)`: Оптимизировать запрос для быстрого получения первых n строк.

3. **Подсказки для управления доступом к данным**:
   - `FULL(table_name)`: Принудительно использовать полное сканирование таблицы.
   - `INDEX(table_name index_name)`: Принудительно использовать указанный индекс для доступа к данным.

4. **Подсказки для управления параллелизмом**:
   - `PARALLEL(table_name, degree)`: Указывает, что операция должна выполняться с указанным уровнем параллелизма.
   - `NOPARALLEL`: Указывает, что операция не должна выполняться в параллельном режиме.

5. **Подсказки для управления кэшированием**:
   - `USE_CACHE`: Указывает, что данные должны быть загружены из кэша.
   - `NO_CACHE`: Указывает, что данные не должны кэшироваться.

6. **Подсказки для управления статистикой**:
   - `OPTIMIZER_MODE`: Позволяет установить режим оптимизации (например, `ALL_ROWS`, `FIRST_ROWS`, `CHOOSE`).

7. **Подсказки для управления использованием материализованных представлений**:
   - `USE_MVIEW`: Указывает использовать материализованные представления, если они существуют.

8. **Подсказки для использования специфических операторов**:
   - `LEADING(table_name)`: Указывает, какая таблица должна быть обработана первой в соединении.

Пример использования подсказки в SQL-запросе:

```sql
SELECT /*+ USE_NL(emp dept) */ *
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id;
```

Пожалуйста, обратите внимание, что использование подсказок не всегда гарантирует улучшение производительности; 
оптимизатор может игнорировать их в зависимости от условий. Поэтому важно тестировать производительность запросов 
с различными подсказками и выбирать наилучший вариант.