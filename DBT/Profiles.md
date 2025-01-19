# profiles.yml

#### Oracle

Настройка переменных среды в powershell:
```
$env:DBT_ORACLE_USER="A_MERKULOV"
$env:DBT_ORACLE_PASSWORD="Password"
$env:DBT_ORACLE_SERVISE="ORCLPDB1"
$env:DBT_ORACLE_DATABASE="ORCLPDB1"
$env:DBT_ORACLE_SCHEMA="A_MERKULOV"
$env:DBT_PROFILES_DIR="path/to/directory"
```

profiles.yml:
```
a_merkulov:
  outputs:
    dev:
      user: "{{ env_var('DBT_ORACLE_USER') }}"
      password: "{{ env_var('DBT_ORACLE_PASSWORD') }}"
      service: "{{ env_var('DBT_ORACLE_SERVISE') }}"
      database: "{{ env_var('DBT_ORACLE_DATABASE') }}"
      schema: "{{ env_var('DBT_ORACLE_SCHEMA') }}"
      host: localhost
      port: 1521
      protocol: tcp
      threads: 10
      type: oracle
  target: dev
```

#### Postgres

Настройка переменных среды в powershell:
```
$env:DBT_POSTGRES_USER="postgres"
$env:DBT_POSTGRES_PASSWORD="Password"
$env:DBT_POSTGRES_DBNAME="postgres"
$env:DBT_POSTGRES_SCHEMA="auto_dv_sources"
$env:DBT_PROFILES_DIR="path/to/directory"
```

profiles.yml:
```
postgres_local:
  outputs:
    dev:
      user: "{{ env_var('DBT_POSTGRES_USER') }}"
      pass: "{{ env_var('DBT_POSTGRES_PASSWORD') }}"
      dbname: "{{ env_var('DBT_POSTGRES_DBNAME') }}"
      schema: "{{ env_var('DBT_POSTGRES_SCHEMA') }}"
      host: localhost
      port: 5433
      threads: 10
      type: postgres
  target: dev
```

#### Пользовательская директория `profiles.yml`

Установка директории с помощью переменной окружения:
```
$env:DBT_PROFILES_DIR="path/to/directory"
```
Команда запуска, когда `profiles.yml` находится в директории `dbt_project.yml`.
```
dbt run --profiles-dir '.\'
```

#### Секреты

Чтобы переменная окружения заменялась на `******` или имя переменной, нужно использовать в имени переменной префикс `DBT_ENV_SECRET`.

#### Установка переменных окружения для пользователя Windows
Чтобы в VSCode? при инициализации `dbt_project.yml` не возникала ошибка из-за отсутствия переменных окружения, нужно установить их следующим способом:
```

```