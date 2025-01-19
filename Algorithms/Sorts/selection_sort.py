def find_smallest(arr):
    '''Алгоритм поиска индекса наименьшего элемента массива.'''
    smallest = arr[0]
    smallest_index = 0
    for i in range(1, len(arr)):
        if arr[i] < smallest:
            smallest = arr[i]
            smallest_index = i

    return smallest_index


def selection_sort(arr):
    '''Алгоритм сортировки массива выбором.'''
    new_arr = []
    for i in range(len(arr)):
        smallest = find_smallest(arr)
        new_arr.append(arr.pop(smallest))

    return new_arr


array = [45, 23, 121, 12, 56, 40] # Массив


print(selection_sort(array))