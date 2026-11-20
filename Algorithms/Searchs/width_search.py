from collections import deque

# Граф представлен в виде словаря
graph = {
    "alice": ["bob", "charlie"],
    "bob": ["anuj", "peggy"],
    "charlie": ["thom", "jonny"],
    "anuj": [],
    "peggy": [],
    "thom": [],
    "jonny": []
}


def person_is_seller(name):
    return name[-1] == 'm'


def width_search(start_name):
    search_queue = deque()
    search_queue += graph[start_name]
    searched = []

    while search_queue:
        person = search_queue.popleft()
        if person not in searched:  # Используем оператор in для проверки
            if person_is_seller(person):
                print(person + " is a seller!")
                return True
            else:
                search_queue += graph[person]
                searched.append(person)  # Добавляем исследованного человека в список

    return False


# Запускаем поиск с начальным именем
width_search("alice")
