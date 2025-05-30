# Инструкция по установке Oracle в docker.

1. Зарегистрироваться на `oracle.com`.
2. Выполнить в powershell `docker login container-registry.oracle.com` и ввести учётные данные. 
3. Запустить команду `docker compose -f "docker-compose.yml" up -d --build`.

#### Настройки СУБД.

```
user\password sys\system
user\password system\system
```

`SELECT * FROM v$version;` -- Версия Oracle.

`conn sys/system@localhost:1521/ORCLPDB1 AS sysdba` -- Подключиться как админ.

`sqlplus system/system@localhost:1521/ORCLPDB1` -- Подключиться как пользователь.

`grant execute on dbms_crypto to SYSTEM;` -- Раздать права.

`ALTER USER system IDENTIFIED BY system;` -- Поменять пароль.