def merge_join(table1, table2, key):
    '''Алгоритм соединения слиянием.'''
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