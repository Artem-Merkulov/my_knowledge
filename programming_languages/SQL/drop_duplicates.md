# Удаление дубликатов в SQL

### Полезные ссылки:
[Удаление одинаковых строк в PostgreSQL](https://otus.ru/nest/post/1394/)

```
-- Удаление всех полных дуюликатов.
DELETE FROM customers WHERE ctid NOT IN
(SELECT max(ctid) FROM customers GROUP BY customers.*);

-- Удаление дубликатов по определённому полю.
DELETE FROM customers WHERE ctid NOT IN
(SELECT max(ctid) FROM customers GROUP BY customer_id);

-- Общая форма.
DELETE FROM table_name WHERE ctid NOT IN 
(SELECT max(ctid) FROM table_name GROUP BY column1, [column 2,] );
```

Или так:

```
-- Создаём таблицу с дубликатами.
DROP TABLE IF EXISTS test_schema.duplicate_table;
CREATE TABLE test_schema.duplicate_table (
    id INT,
    value_int INT,
    value_char VARCHAR
)

-- Заполняем её данными.
INSERT INTO test_schema.duplicate_table (id, value_int, value_char)
VALUES 
(1, 10, 'ten'),
(2, 20, 'twenty'),
(3, 30, 'thirty'),
(4, 40, 'fourty'),
(5, 50, 'fifty'),
(1, 10, 'ten'),
(2, 20, 'twenty'),
(3, 30, 'thirty'),
(4, 40, 'fourty'),
(5, 50, 'fifty');

-- Смотрим на дубликаты.
SELECT * FROM test_schema.duplicate_table;

-- Смотрим как работает запрос с rn.
WITH duplicates AS (
    SELECT id, value_int, value_char,
          ROW_NUMBER() OVER(PARTITION BY id, value_int, value_char ORDER BY id) AS rn
    FROM test_schema.duplicate_table
)
SELECT * FROM duplicates;

-- Создаём таблицу для сохранения данных с дубликатами.
CREATE TEMPORARY TABLE duplicates AS (
    SELECT id, value_int, value_char,
           ROW_NUMBER() OVER(PARTITION BY id, value_int, value_char ORDER BY id) AS rn
    FROM test_schema.duplicate_table
);

-- Создаём таблицу без дубликатов.
DROP TABLE IF EXISTS test_schema.duplicate_table;
CREATE TABLE test_schema.duplicate_table AS (
    SELECT id, value_int, value_char,
           ROW_NUMBER() OVER(PARTITION BY id, value_int, value_char ORDER BY id) AS rn
    FROM duplicates
    WHERE rn = 1
);

-- Удаляем временную таблицу.
DROP TABLE duplicates;

-- Смотрим на очищенную от дуюликатов таблицу.
SELECT * FROM test_schema.duplicate_table;


-- С использованием скрытого поля ctid.
DELETE FROM test_schema.duplicate_table WHERE ctid NOT IN
(SELECT max(ctid) FROM test_schema.duplicate_table GROUP BY test_schema.duplicate_table.*);
```

Может сработать такое:
```
DELETE FROM test_schema.duplicate_table WHERE ctid IN (
SELECT
	dt.ctid
FROM
	(
	SELECT
		ctid,
		id,
		value_int,
		value_char,
		ROW_NUMBER() OVER (PARTITION BY id,
										value_int,
										value_char) rn
	FROM
		test_schema.duplicate_table) dt
WHERE
	dt.rn > 1);
```