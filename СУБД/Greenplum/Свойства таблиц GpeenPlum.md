# Свойства таблиц GpeenPlum

**Все свойства должны быть заданы в явном виде в скрипте создания таблицы:**
```
with
(
 orientation = <>,
 appendonly = <>,
 compresstype = <>,
 compresslevel = <>
)
distributed by (<>);
```


**При указании свойств таблиц ориентируемся на ожидаемое количество строк в данной таблице:
n < 10 000: orientation = row, distributed replicated;**
```
with
(
 orientation = row,
 appendonly = true,
 compresstype = zstd,
 compresslevel = 5
)
distributed replicated;
```


**10 000 <= n < 100 000: orientation = row;**
```
with
(
 orientation = row,
 appendonly = true,
 compresstype = zstd,
 compresslevel = 5
)
distributed by (field);
```


**100 000 <= n: orientation = column;**
```
with
(
 orientation = column,
 appendonly = true,
 compresstype = zstd,
 compresslevel = 5
)
distributed by (field);
```

Могут быть исключения по свойствам таблицы, если это обусловлено фактами эксплуатации, производительности. Решается на архкомитете.
В качестве ключа дистрибуции (distributed by) выбирается суррогатный первичный ключ таблицы. В случае, если это небольшой (до 10000 строк) 
справочник, выбирается реплицированное распределение (distributed replicated). Могут быть исключения, если это обусловлено фактами 
эксплуатации, производительности. Решается на архкомитете. Случайное распределение (distributed randomly) также требует обоснования на 
архкомитете.

Для самой таблицы и для всех полей должен быть установлен комментарий-описание comment on table, comment on column.
(! обсудить) null поля не использовать - увеличивает риск возникновения spill файлов, деградации производительности, в clickhouse аналогично + 
требуют дополнительного места для хранения.