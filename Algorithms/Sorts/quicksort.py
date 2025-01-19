def quicksort(arr):
    '''Алгоритм быстрой сортировки.'''
    if len(arr) <= 1:
        return arr
    else:
        pivot = arr[0]
        less = [i for i in arr[1:] if i < pivot]
        greater = [i for i in arr[1:] if i > pivot]
        return quicksort(less) + [pivot] + quicksort(greater)

print(quicksort([10,8,3,5,2,0,1,6,7,4,9]))