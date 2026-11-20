# Cross-database DBT-project

### Шаги:

#### 1. Настройка профиля

В файле profiles.yml, который обычно находится в директории .dbt/, вы можете определить несколько профилей для различных СУБД. Например, у вас может быть профиль для Oracle и другой для PostgreSQL.

Пример конфигурации для двух профилей:

my_project:
  target: dev
  outputs:
    dev:
      type: oracle
      host: your-oracle-host
      port: 1521
      user: oracle_user
      password: oracle_password
      database: oracle_db_name
      schema: my_schema_oracle
      
    prod:
      type: postgres
      host: your-postgres-host
      user: postgres_user
      password: postgres_password
      port: 5432
      dbname: postgres_db_name
      schema: my_schema_postgres


Здесь у нас два профиля:
- dev – для работы с Oracle.
- prod – для работы с PostgreSQL.

#### 2. Использование целевых объектов

Теперь в вашем проекте DBT вы можете указать целевой объект при запуске команд. Например, чтобы запустить модели для одной базы данных, а затем для другой, вы можете использовать команду --target.

Например:

# Запуск моделей для Oracle
dbt run --target dev

# Запуск моделей для PostgreSQL
dbt run --target prod


#### 3. Альтернативный подход: переменные окружения

Вы также можете использовать переменные окружения для динамической настройки профилей. Для этого нужно настроить файл profiles.yml так, чтобы он использовал переменные окружения.

Пример:

my_project:
  target: dev
  outputs:
    dev:
      type: oracle
      host: "{{ env_var('ORACLE_HOST') }}"
      port: 1521
      user: "{{ env_var('ORACLE_USER') }}"
      password: "{{ env_var('ORACLE_PASSWORD') }}"
      database: "{{ env_var('ORACLE_DB_NAME') }}"
      schema: my_schema_oracle
    
    prod:
      type: postgres
      host: "{{ env_var('POSTGRES_HOST') }}"
      user: "{{ env_var('POSTGRES_USER') }}"
      password: "{{ env_var('POSTGRES_PASSWORD') }}"
      port: 5432
      dbname: "{{ env_var('POSTGRES_DB_NAME') }}"
      schema: my_schema_postgres


Затем установите соответствующие переменные окружения перед запуском DBT-команд:

export ORACLE_HOST=your-oracle-host
export ORACLE_USER=oracle_user
export ORACLE_PASSWORD=oracle_password
export ORACLE_DB_NAME=oracle_db_name

export POSTGRES_HOST=your-postgres-host
export POSTGRES_USER=postgres_user
export POSTGRES_PASSWORD=postgres_password
export POSTGRES_DB_NAME=postgres_db_name


Таким образом, вы сможете переключаться между различными СУБД в рамках одного проекта, используя разные профили и целевые объекты.


### Полезные материалы:

- [How to use ONE dbt project for all environments](https://youtu.be/qxFxOBPyZNY?si=L6i1Bv2YJgZZX1he)
- [How to connect DBT to multiple databases in the same project](https://www.datameer.com/blog/how-to-connect-dbt-to-multiple-databases-in-the-same-project/)