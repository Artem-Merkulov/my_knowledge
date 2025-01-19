def binary_search(arr, target, low, high):
    # Базовый случай: если нижний индекс превышает верхний, элемент не найден
    if low > high:
        return -1  # Элемент не найден

    mid = (low + high) // 2  # Находим средний индекс

    # Если элемент найден на среднем индексе
    if arr[mid] == target:
        return mid
    # Если целевой элемент меньше, ищем в левой половине
    elif arr[mid] > target:
        return binary_search(arr, target, low, mid - 1)
    # Если целевой элемент больше, ищем в правой половине
    else:
        return binary_search(arr, target, mid + 1, high)

# Пример использования
sorted_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
target_value = 7
result = binary_search(sorted_array, target_value, 0, len(sorted_array) - 1)

if result != -1:
    print(f"Элемент {target_value} найден на индексе {result}.")
else:
    print(f"Элемент {target_value} не найден.")