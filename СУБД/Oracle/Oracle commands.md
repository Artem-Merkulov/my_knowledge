# Полезные команды Oracle

#### Зайти в контейнер с Oracle через терминал
```
docker exec -u 0 -it oracle_docker_compose bash
```

#### Создать нового пользователя
```
CREATE USER DBT IDENTIFIED BY dbt;
```

#### Раздать права
```
sqlplus sys/system@localhost:1521/ORCLPDB1 AS sysdba; -- Подключиться как админ.

conn system/system@localhost:1521/ORCLPDB1; -- Подключиться как пользователь.

grant execute on dbms_crypto to SYSTEM; -- Раздать права.

grant create table to A_MERKULOV; -- Дать право создавать таблицу.

alter user A_MERKULOV quota unlimited on users; -- Дать квоту на заполнение таблиц.

grant create view to A_MERKULOV; -- Дать право создавать представление.

grant create materialized view to A_MERKULOV; -- Дать право создавать материализованное представление.

grant create procedure to A_MERKULOV; -- Дать право создавать процедуру.

grant create sequence to A_MERKULOV; -- Дать право создавать последовательность.

GRANT CREATE ANY TABLE TO A_MERKULOV; -- Дать права управлять таблицами в других схемах.

GRANT ALL PRIVILEGES TO DBT; -- Дать все права.
```

####
```
SELECT USER FROM DUAL; -- Определить под каким пользователем открыта сессия.
```

#### Поменять пароль
```
ALTER USER system IDENTIFIED BY system; -- Поменять пароль.
```

#### Узнать версию Oracle
```
SELECT * FROM v$version; -- Версия Oracle.
```

#### Запись в другую схему
Если подключиться за пользователя PIVO для редактирования таблиц в схеме TEST (или DWH_MD), нужно давать привилегию на tablespace не user, с которого подключаешься, а  юзеру который владеет схемой (его имя совпадает с именем схемы).
Таким образом, надо было выполнять не:
```
ALTER USER pivo QUOTA UNLIMITED ON USERS;
```
А:
```
ALTER USER dwh_md QUOTA UNLIMITED ON USERS;
```
Но этом надо ещё дать привелегии на определенные таблицы и последовательности пользователю pivo.

#### Дать пользователю права на использование библиотеки `DBMS_CRYPTO`
```
GRANT EXECUTE ON DBMS_CRYPTO TO DBT;
```
`ALL PRIVILEGES` в этом случае не подходит.


#### Минимальные права (только чтение V$SYSTEM_PARAMETER)
```
GRANT SELECT ON v_$system_parameter TO ваш_пользователь;
```

#### Или более широкие права (рекомендуется для разработчиков)
```
GRANT SELECT_CATALOG_ROLE TO ваш_пользователь;
```

#### Или самые полные права (только для доверенных пользователей)
```
GRANT SELECT ANY DICTIONARY TO DBT;
```

#### Смена пароля (подключиться как админ)
```
ALTER USER username IDENTIFIED BY new_pass ACCOUNT UNLOCK;
```

#### Разблокировать пользователя
```
ALTER USER A_MERKULOV ACCOUNT UNLOCK;
```

#### Отключить блокировку для конкретного пользователя
```
ALTER USER DBT PROFILE DEFAULT;
ALTER PROFILE DEFAULT LIMIT FAILED_LOGIN_ATTEMPTS UNLIMITED PASSWORD_LOCK_TIME UNLIMITED;
```