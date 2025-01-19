def sum_array(arr):
    # Базовый случай: если список пустой, возвращаем 0.
    if not arr:
        return 0
    # Рекурсивный случай: складываем первый элемент с суммой оставшихся элементов.
    return arr[0] + sum_array(arr[1:])

# Пример использования
numbers = [1, 2, 3, 4, 5]
result = sum_array(numbers)
print(result)  # Вывод: 15