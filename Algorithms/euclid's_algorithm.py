def get_nod(a, b):
    """НОД для натуральных чисел a и b
        по алгоритму Евклида.
        Возвращает вычисленный НОД."""
    while a != b:
        if a > b:
            a -= b
        else:
            b -= a
    return a


def get_fast_nod(a, b):
    """НОД для натуральных чисел a и b
        по быстрому алгоритму Евклида.
        Возвращает вычисленный НОД.
    """
    if a < b:
        a, b = b, a

    while b != 0:
        a, b = b, a % b
    return a


print(get_nod(120, 30))
print()
print(get_fast_nod(120, 30))