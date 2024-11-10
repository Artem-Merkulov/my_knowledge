# PSQL COPY
Инициализация:
```
psql -h localhost -p 5433 -U postgres -d postgres
```
Копирование:
```
\COPY auto_dv.group_log FROM 'C:\Glowbyte\Projects\AutoDV\sources\group_log.csv' DELIMITER ',' CSV HEADER;
\COPY auto_dv.user FROM 'C:\Glowbyte\Projects\AutoDV\sources\user.csv' DELIMITER ',' CSV HEADER;
```