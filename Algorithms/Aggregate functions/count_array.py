def count_array(arr):
    # Базовый случай: если список пустой, возвращаем 0.
    if not arr:
        return 0
    # Рекурсивный случай: складываем 1 с количеством оставшихся элементов.
    return 1 + count_array(arr[1:])

# Пример использования
numbers = [1, 2, 3, 4, 5]
result = count_array(numbers)
print(result)  # Вывод: 5