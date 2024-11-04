# JOIN в SQL

### CROSS JOIN
Перекрестное соединение возвращает декартово произведение двух отношений.

### INNER JOIN
INNER JOIN - все комбинации строк (CROSS JOIN), отфильтрованные по выражению ON
```
t1 INNER JOIN t2                         t1 CROSS JOIN t2
ON condition               ==            WHERE condition
```

### LEFT JOIN
LEFT JOIN - то же самое, что и INNER JOIN + строки из левой таблицы,
для которой в правой таблице не нашлось совпадений, в соответствии с условием.


### FULL JOIN
Полное соединение возвращает все значения из обоих отношений, 
добавляя значения NULL на стороне, не имеющей совпадений. 
Его также называют полным внешним соединением.


### SEMI JOIN
Выводит отдельные записи, принадлежащие только одному из двух входных наборов данных, 
в совпадающем, либо в несовпадающем экземпляре.


### ANTI JOIN
Возвращает значения из левого отношения, которые не совпадают с правым. Его также называют левым антисоединением.


[Spark JOIN](https://spark.apache.org/docs/latest/sql-ref-syntax-qry-select-join.html)

[Понимание джойнов](https://habr.com/ru/articles/448072/)

**Практика:**

```
-- Создадим 2 таблицы.

DROP TABLE IF EXISTS test_schema.join_t1;
CREATE TABLE test_schema.join_t1(value_t1 VARCHAR);

INSERT INTO test_schema.join_t1(value_t1)
VALUES
(1),
(2),
(2),
(3),
(4),
(''),
(NULL);

DROP TABLE IF EXISTS test_schema.join_t2;
CREATE TABLE test_schema.join_t2(value_t2 VARCHAR);

INSERT INTO test_schema.join_t2(value_t2)
VALUES
(1),
(1),
(1),
(2),
(2),
(3),
(5),
(''),
(NULL);

SELECT value_t1 FROM test_schema.join_t1;

-- Вывод
value_t1|
--------+
1       |
2       |
2       |
3       |
4       |
        |
NULL    |

SELECT value_t2 FROM test_schema.join_t2;

-- Вывод
value_t2|
--------+
1       |
1       |
1       |
2       |
2       |
3       |
5       |
        |
NULL    |


-- INNER JOIN
SELECT value_t1, value_t2
FROM test_schema.join_t1 t1
INNER JOIN test_schema.join_t2 t2 ON t1.value_t1 = t2.value_t2;

-- Вывод
value_t1|value_t2|
--------+--------+
        |        |
1       |1       |
1       |1       |
1       |1       |
2       |2       |
2       |2       |
2       |2       |
2       |2       |
3       |3       |


-- LEFT JOIN
SELECT value_t1, value_t2
FROM test_schema.join_t1 t1
LEFT JOIN test_schema.join_t2 t2 ON t1.value_t1 = t2.value_t2;

-- Вывод
value_t1|value_t2|
--------+--------+
        |        |
1       |1       |
1       |1       |
1       |1       |
2       |2       |
2       |2       |
2       |2       |
2       |2       |
3       |3       |
4       |NULL    |
NULL    |NULL    |


-- RIGHT JOIN
SELECT value_t1, value_t2
FROM test_schema.join_t1 t1
RIGHT JOIN test_schema.join_t2 t2 ON t1.value_t1 = t2.value_t2;

-- Вывод
value_t1|value_t2|
--------+--------+
        |        |
1       |1       |
1       |1       |
1       |1       |
2       |2       |
2       |2       |
2       |2       |
2       |2       |
3       |3       |
NULL    |5       |
NULL    |NULL    |


-- FULL OUTER JOIN
SELECT value_t1, value_t2
FROM test_schema.join_t1 t1
FULL OUTER JOIN test_schema.join_t2 t2 ON t1.value_t1 = t2.value_t2;

-- Вывод
value_t1|value_t2|
--------+--------+
        |        |
1       |1       |
1       |1       |
1       |1       |
2       |2       |
2       |2       |
2       |2       |
2       |2       |
3       |3       |
4       |NULL    |
NULL    |NULL    |
NULL    |5       |
NULL    |NULL    |

-- SELF JOIN
/*Представим, что есть таблица «employees» с столбцами «employee_id», «employee_name» и «manager_id» (где «manager_id» указывает на «employee_id» менеджера). Нужно получить список сотрудников и их соответствующих имён менеджеров. Для этого можно использовать самосоединение:*/

SELECT e.employee_name, m.employee_name AS manager_name
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.employee_id;
```

### LATERAL JOIN

**LATERAL JOIN** — это конструкция в SQL, которая позволяет использовать данные из одной таблицы в подзапросе, который ссылается на строки из другой таблицы. Это позволяет создавать более сложные запросы, где подзапрос может зависеть от текущей строки основной таблицы.

В частности, LATERAL JOIN позволяет вам выполнять подзапросы, которые могут возвращать несколько строк для каждой строки основной таблицы. Это особенно полезно в случаях, когда необходимо извлечь данные, которые зависят от значений в соответствующей строке.

**Объяснение:**

1. **Основная таблица**: `employees` (сотрудники).
2. **LATERAL подзапрос**: Он выбирает имя самого высокооплачиваемого сотрудника из того же отдела, что и текущий сотрудник `e`.
3. **JOIN ON true**: Здесь мы используем условие `ON true`, потому что нам не нужно дополнительное условие для соединения, так как подзапрос уже зависит от текущей строки `e`.

LATERAL JOIN поддерживается не всеми СУБД, поэтому стоит проверить документацию конкретной системы управления базами данных, которую вы используете.

**Практика:**
```
-- Lateral join
CREATE TABLE test_schema.employees_with_salary(
    id INT,
    name VARCHAR,
    department VARCHAR,
    salary INT
);

INSERT INTO test_schema.employees_with_salary(
    id,
    "name",
    department,
    salary
)
VALUES
    (1, 'Анна', 'IT', 1000),
    (2, 'Борис', 'IT', 1200),
    (3, 'Света', 'HR', 900),
    (4, 'Олег', 'HR', 1100);
    
SELECT * FROM test_schema.employees_with_salary;

SELECT e."name" AS emp_name, 
       highest_paid."name" AS highest_salary_emp_name
FROM test_schema.employees_with_salary e
JOIN LATERAL (
    SELECT "name"
    FROM test_schema.employees_with_salary
    WHERE department = e.department
    ORDER BY salary DESC
    LIMIT 1
) AS highest_paid ON true;

-- Вывод:
emp_name|highest_salary_emp_name|
--------+-----------------------+
Анна    |Борис                  |
Борис   |Борис                  |
Света   |Олег                   |
Олег    |Олег                   |
```




**Пример использования LATERAL JOIN**

Предположим, у вас есть две таблицы: `employees` и `departments`. Вы хотите получить список всех сотрудников вместе с их самыми высокооплачиваемыми коллегами из того же отдела. Вы можете использовать LATERAL JOIN, чтобы сделать это:

```sql
SELECT e.name AS employee_name, 
       d.highest_paid.name AS highest_paid_name
FROM employees e
JOIN LATERAL (
    SELECT name
    FROM employees
    WHERE department_id = e.department_id
    ORDER BY salary DESC
    LIMIT 1
) AS d(highest_paid) ON true;
```




### Физические JOINs

**Полезные материалы**

[Алгоритмы объединения таблиц](https://youtu.be/xeFAgX1pXZU?si=KG0qvRk2hwgPDrkp)

**NESTED LOOPS**

Алгоритм JOIN с использованием вложенных циклов (nested loops) выполняет объединение двух таблиц (или списков) по определенному условию. Предположим, у нас есть две таблицы, которые представлены в виде списков словарей, и мы хотим выполнить внутреннее объединение (INNER JOIN) на основе общего ключа.

Вот пример реализации такого алгоритма на Python:

```python
def nested_loops_join(table1, table2, key):
    result = []
    
    for row1 in table1:
        for row2 in table2:
            if row1[key] == row2[key]:  # Условие объединения
                joined_row = {**row1, **row2}  # Объединяем строки
                result.append(joined_row)
    
    return result

# Пример данных
table1 = [
    {'id': 1, 'name': 'Alice'},
    {'id': 2, 'name': 'Bob'},
    {'id': 3, 'name': 'Charlie'},
]

table2 = [
    {'id': 1, 'age': 30},
    {'id': 2, 'age': 25},
    {'id': 4, 'age': 40},
]

# Выполняем JOIN по полю 'id'
joined_result = nested_loops_join(table1, table2, 'id')

# Выводим результат
for row in joined_result:
    print(row)
```

**Объяснение кода:**
1. **Функция `nested_loops_join`**: принимает две таблицы (списки словарей) и ключ для объединения.
2. **Вложенные циклы**: два цикла `for` перебирают все строки обеих таблиц.
3. **Условие объединения**: проверяем, равны ли значения по ключу `key` в обеих строках.
4. **Объединение строк**: если условие выполняется, объединяем строки с помощью распаковки словарей и добавляем результат в список `result`.
5. **Пример данных**: создаем две таблицы с некоторыми данными.
6. **Вызов функции**: выполняем объединение и выводим результат.


**MERGE JOIN**

Алгоритм MERGE JOIN (слияние) предполагает, что обе таблицы (или списки) предварительно отсортированы по ключу, по которому мы хотим выполнять объединение. Этот алгоритм работает более эффективно, чем вложенные циклы, так как использует один проход по каждой из таблиц.

Вот пример реализации MERGE JOIN на Python:

```python
def merge_join(table1, table2, key):
    result = []
    i, j = 0, 0
    len1, len2 = len(table1), len(table2)
    
    # Проходим по обеим таблицам, пока не достигнем конца одной из них
    while i < len1 and j < len2:
        if table1[i][key] < table2[j][key]:
            i += 1  # Переходим к следующему элементу в первой таблице
        elif table1[i][key] > table2[j][key]:
            j += 1  # Переходим к следующему элементу во второй таблице
        else:
            # Ключи совпадают, объединяем строки
            joined_row = {**table1[i], **table2[j]}  # Объединяем строки
            result.append(joined_row)
            i += 1
            j += 1
            
    return result

# Пример данных (предполагается, что данные отсортированы по 'id')
table1 = [
    {'id': 1, 'name': 'Alice'},
    {'id': 2, 'name': 'Bob'},
    {'id': 3, 'name': 'Charlie'},
]

table2 = [
    {'id': 1, 'age': 30},
    {'id': 2, 'age': 25},
    {'id': 4, 'age': 40},
]

# Выполняем JOIN по полю 'id'
joined_result = merge_join(table1, table2, 'id')

# Выводим результат
for row in joined_result:
    print(row)
```

**Объяснение кода:**
1. **Функция `merge_join`**: принимает две отсортированные таблицы (списки словарей) и ключ для объединения.
2. **Индексы `i` и `j`**: используются для отслеживания текущих позиций в обеих таблицах.
3. **Цикл `while`**: продолжается до тех пор, пока не будет достигнут конец одной из таблиц.
4. **Сравнение ключей**: если ключ в первой таблице меньше, переходим к следующему элементу в первой таблице; если больше — во второй таблице; если равны — объединяем строки и добавляем в результат.
5. **Пример данных**: создаются две отсортированные таблицы.
6. **Вызов функции**: выполняется объединение и выводится результат.


**HASH JOIN**

Алгоритм HASH JOIN использует хеш-таблицы для выполнения объединения двух таблиц. Сначала он создает хеш-таблицу для одной из таблиц (обычно меньшей), а затем перебирает другую таблицу, чтобы найти совпадения. Это позволяет значительно ускорить процесс объединения по сравнению с вложенными циклами, особенно для больших наборов данных.

Вот пример реализации HASH JOIN на Python:

```python
def hash_join(table1, table2, key):
    # Создаем хеш-таблицу для первой таблицы
    hash_table = {}
    
    # Заполняем хеш-таблицу
    for row in table1:
        hash_key = row[key]
        if hash_key not in hash_table:
            hash_table[hash_key] = []
        hash_table[hash_key].append(row)
    
    result = []
    
    # Перебираем вторую таблицу и ищем совпадения в хеш-таблице
    for row in table2:
        hash_key = row[key]
        if hash_key in hash_table:
            # Если нашли совпадения, объединяем строки
            for matched_row in hash_table[hash_key]:
                joined_row = {**matched_row, **row}  # Объединяем строки
                result.append(joined_row)
    
    return result

# Пример данных
table1 = [
    {'id': 1, 'name': 'Alice'},
    {'id': 2, 'name': 'Bob'},
    {'id': 3, 'name': 'Charlie'},
]

table2 = [
    {'id': 1, 'age': 30},
    {'id': 2, 'age': 25},
    {'id': 4, 'age': 40},
]

# Выполняем JOIN по полю 'id'
joined_result = hash_join(table1, table2, 'id')

# Выводим результат
for row in joined_result:
    print(row)
```

**Объяснение кода:**
1. **Функция `hash_join`**: принимает две таблицы (списки словарей) и ключ для объединения.
2. **Создание хеш-таблицы**: заполняем хеш-таблицу для первой таблицы, используя значения ключа в качестве хеш-ключей.
3. **Перебор второй таблицы**: ищем совпадения в хеш-таблице для каждого элемента второй таблицы.
4. **Объединение строк**: если совпадения найдены, объединяем строки и добавляем в результат.
5. **Пример данных**: создаются две таблицы с некоторыми данными.
6. **Вызов функции**: выполняем объединение и выводим результат.