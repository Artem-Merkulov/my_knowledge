def binary_search(array: list, number: int) -> int:
    '''Алгоритм бинарного поиска.'''
    low = 0 # Левая граница массива.
    high = len(array) - 1 # Правая граница массива.

    while low <= high: # Пока массив не сократится до одного жлемента, проверяем средний элемент.
        mid = (low + high) // 2 # Определяется индекс среднего элемента массива.
        guess = array[mid] # Определяется среднее значение массива.
        if guess == number: # начение найдено.
            return mid
        elif guess > number: # Много.
            high = mid - 1
        else: low = mid + 1 # Мало.

    return None


array = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45] # Массив
number = 27 # Число


print(binary_search(array, number))