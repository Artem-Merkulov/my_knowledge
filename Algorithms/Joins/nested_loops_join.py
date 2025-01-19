def nested_loops_join(table1, table2, key):
    '''JOIN с использованием вложенных циклов.'''
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