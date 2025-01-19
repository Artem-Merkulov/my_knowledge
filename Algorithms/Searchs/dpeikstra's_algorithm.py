# Алгоритм Дейкстры.

# Граф.
graph = {}
graph["start"] = {}
graph["start"]["a"] = 6
graph["start"]["b"] = 2
graph["a"] = {}
graph["a"]["final"] = 1
graph["b"] = {}
graph["b"]["a"] = 3
graph["b"]["final"] = 5
graph["final"] = {}

# Стоимости costs.
infinity = float('inf')
costs = {}
costs["a"] = 6
costs["b"] = 2
costs["final"] = infinity

# Родители parents.
parents = {}
parents["a"] = "start"
parents["b"] = "start"
parents["final"] = None

processed = []

# Найти узел с меньшей стоимостью.
def find_lowest_cost_node(costs):
    lowest_cost = float('inf')
    lowest_cost_node = None
    for node in costs:
        cost = costs[node]
        if cost < lowest_cost and node not in processed:
            lowest_cost = cost
            lowest_cost_node = node
    return lowest_cost_node

# Алгоритм Дейкстры.
def dpeikstras_algorithm(graph, costs, parents):
    node = find_lowest_cost_node(costs)
    while node is not None:
        cost = costs[node]
        neighbors = graph[node]
        for n in neighbors.keys():
            new_cost = cost + neighbors[n]
            if costs[n] > new_cost:
                costs[n] = new_cost
                parents[n] = node
        processed.append(node)
        node = find_lowest_cost_node(costs)

# Запуск алгоритма
dpeikstras_algorithm(graph, costs, parents)

# Вывод результатов
print("Costs:", costs)
print("Parents:", parents)