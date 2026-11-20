def look_for_key(box):
    '''Поиск ключа в куче коробок.'''
    for item in box:
        if item.is_a_box():
            look_for_key(item)
        elif item.is_a_key():
            print("Found the key!")

def countdown(n):
    '''Обратный отсчёт до нуля.'''
    print(n)
    if n == 0:  # Базовый случай.
        return
    else:       # Рекурсивный случай.
        countdown(n-1)


def fact(x):
    '''Расчёт факториала.'''
    if x == 1:
        return 1
    else:
        return x * fact(x-1)


print(fact(5))
print()
print(countdown(5))
