# Оптимизация SQL запросов
### Полезные материалы

- [Как ускорить запросы в 1000 раз](https://www.youtube.com/watch?v=jqSUnt0EVV8)
- [11 Методов оптимизации SQL](https://dzen.ru/a/YtZh8w4yXCQoTBp3)
- [Помощник проверки планов запросов](https://planchecker.arenadata.io/plan/)
### Оптимизация SQL-запросов

**Query planner**
```
-- Workers plan
EXPLAIN SELECT *
        FROM public.users;
```