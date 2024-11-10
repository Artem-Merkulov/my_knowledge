# Правила использования DBT

- Нужно использовать CTE для абстрагирования от сложной логики
  что приводит к более читаемому и модульному запросу:
  ```
  SELECT cul1, col2
  FROM t1;
 

  Equals

  WITH cte AS (
  SELECT col1, col2
  FROM t1
  )
  SELECT *
  FROM cte;
  ```


- Материализация по-умолчанию для DBT - это представление, но
  его можно настроить или изменить на таблицу в файле
  `dbt_project.yml` (файл проекта):
  ```
  models:
  test_dbt_proj:
    # Config indicated by + and applies to all files under models/example/
    example:
      +materialized: view (<-тут)

  Equals

  {{ config(materialized='table') }} (<-тут)
  WITH cte AS (
  SELECT customer_id, order_id
  FROM customer JOIN order USING(customer_id)
  )
  SELECT customer_id, order_id
  FROM cte;
  ```
  При выполнении команды dbt run, dbt создаст это представление с именем customers в целевой     схеме ([документация](https://docs.getdbt.com/docs/build/sql-models)):
  ```
  create view dbt_alice.customers as (
    with customer_orders as (
        select
            customer_id,
            min(order_date) as first_order_date,
            max(order_date) as most_recent_order_date,
            count(order_id) as number_of_orders

        from jaffle_shop.orders

        group by 1
    )

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from jaffle_shop.customers

    left join customer_orders using (customer_id)
  )
  ```



- [Модульный подход](https://docs.getdbt.com/reference/dbt-jinja-functions/ref) 
  ```
  select * from {{ ref('project_or_package', 'model_name') }}
  ```

  Однако бывают случаи, когда dbt не знает, когда должна быть запущена модель. 
  Примером этого может служить ситуация, когда модель ссылается только на макрос.

  Чтобы решить эту проблему, можно использовать SQL—комментарий вместе с 
  функцией ref - dbt поймет зависимость, и скомпилированный запрос по-прежнему 
  будет действительным:

  ```
  -- depends_on: {{ ref('upstream_parent_model') }}

  {{ your_macro('variable') }}
  ```


  Другой пример - когда ссылка появляется в условном блоке `is_incremental()``. 
  Это связано с тем, что макрос `is_incremental()`` всегда возвращает значение 
  false во время синтаксического анализа, поэтому любые ссылки в нем не могут 
  быть выведены. Чтобы справиться с этим, можно использовать SQL-комментарий 
  вне условия `is_incremental()`:

  ```
  -- depends_on: {{ source('raw', 'orders') }}

  {% if is_incremental() %}
  select * from {{ source('raw', 'orders') }}
  {% endif %}
  ```