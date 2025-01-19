# Добавление host.docker.internal

Прописать в docker-compose.yml
```
version: '3'

services:

  sleek-airflow:
    image: sleek_airflow:latest
    volumes:
      - ./airflow:/opt/airflow
    extra_hosts:
      - "host.docker.internal:host-gateway"
    ports:
      - "8080:8080"
    command: airflow standalone
```

Строку:
```
	extra_hosts:
      - "host.docker.internal:host-gateway"
```

Перезапустить контейнер командой:
```
docker run --network="host" sleek_airflow:latest
```

В контейнере в exec проверить подключение к PostgreSQL:
```
psql -h host.docker.internal -p 5433 -U postgres -d postgres -W
```

В Airflow Connection прописать host: host.docker.internal