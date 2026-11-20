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