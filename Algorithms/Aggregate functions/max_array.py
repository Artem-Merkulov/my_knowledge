def max_array(arr):
    # Базовый случай: если список состоит из двух значений, возвращаем наибольшее.
    if len(arr) == 2:
        return arr[0] if arr[0] > arr[1] else arr[1]
    sub_max = max_array(arr[1:])
    # Рекурсивный случай: Сравниваем первый элемент списка (`arr[0]`) с найденным максимальным значением (`sub_max`).
    return arr[0] if arr[0] > sub_max else sub_max

# Пример использования
numbers = [5, 1, 8, 3, 7]
result = max_array(numbers)
print(result)  # Вывод: 5