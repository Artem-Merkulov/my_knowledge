# Приближенный алгоритм.

# Задача: Найти минимальное количество радиостанций, необходимое для покрытия всех штатов США.

def greedy_radio_stations(states_needed, stations):
    # Структура данных для хранения итогового набора данных.
    final_stations = set()

    # Вычисление ответа:
    while states_needed:
        best_station = None
        states_covered = set()

        # Перебираем все станции и находим среди них ту, которая покрывает больше всего штатов.
        for station, states in stations.items():
            covered = states_needed & states
            if len(covered) > len(states_covered):
                best_station = station
                states_covered = covered

        # Удаляем покрытые штаты из необходимых
        states_needed -= states_covered
        # Добавляем лучшую станцию в финальный набор
        final_stations.add(best_station)

    return final_stations


# Список штатов, которые необходимо покрыть
states_needed = set(["mt", "wa", "or", "id", "nv", "ut", "ca", "az"])

# Список станций из которых будет выбираться покрытие:
stations = {
    "kone": set(["id", "nv", "ut"]),
    "ktwo": set(["wa", "id", "mt"]),
    "kthree": set(["or", "nv", "ca"]),
    "kfour": set(["nv", "ut"]),
    "kfive": set(["ca", "az"])
}

# Вызов функции и вывод результата
result = greedy_radio_stations(states_needed, stations)
print(result)