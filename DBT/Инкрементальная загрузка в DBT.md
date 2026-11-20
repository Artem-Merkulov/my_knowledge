# Инкрементальная загрузка в DBT
Опишем модель `stage_source.sql`:

```
{{
    config(
        materialized='incremental'
    )
}}


select distinct on (src.id)
    src.*
from
    {{ source('raw', 'raw_source') }} src
{% if is_incremental() %}
    left join
    {{ this }} dst
    on src.id = dst.id
where dst.id is null
{% endif %}
```

При первичным запуске итоговый `select` запрос будет выглядеть следующим образом:

```
select distinct on (src.id)
    src.*
from
    "dbt_intro_db"."public"."raw_source" src
```

Видно, что мы выбираем все данные из `raw_source` и дедублицируем их по `src.id`

Если же мы попробуем запустить второй раз:

```
select distinct on (src.id)
    src.*
from
    "dbt_intro_db"."public"."raw_source" src
    left join
    "dbt_intro_db"."public"."stage_source" dst
    on src.id = dst.id
where dst.id is null
```


Теперь же мы сначала пытаемся найти данные, которых 
еще нет в `stage_source` и после этого дедублицируем их по ключу `src.id`