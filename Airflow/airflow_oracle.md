# Добавление airflow connection oracle type.

Чтобы добавить airflow connection type - oracle, (Oracle в одном docker-контейнере, airflow - в другом) нужно установить в контейнере airflow следующие python библиотеки:
```
python -m pip install oracledb # Ранее pip install cx_Oracle.
pip install apache-airflow-providers-oracle -- сам устанавливает oracledb.
```
Появится Oracle connection.

В настройках connection, указать host:
```
host.docker.internal
```

В docker-compose.yml Airflow указать строку `extra_hosts`:
```
version: '3'

services:

  sleek-airflow:
    image: sleek_airflow:latest
    volumes:
      - ./airflow:/opt/airflow
      - C:\Glowbyte\Projects\OracleDV\A_MERKULOV:/opt/airflow/A_MERKULOV
    extra_hosts:
      - "host.docker.internal:host-gateway"
    ports:
      - "8080:8080"
    command: airflow standalone
```

airflow config set core.test_connection Enabled

Настроить кнопку `Test Connection в docker`:
```
/usr/local/airflow/airflow.cfg

test_connection = Enabled

Webserver и scheduler.
```

Обновление списка hosts на Windows:
1. Список хостов hosts на windows: `C:\Windows\System32\drivers\etc\hosts`.
2. Добавить или раскомментировать нужный хост.
3. Открыть командную строку (win+r → cmd ) и выполни команду "ipconfig /flushdns".