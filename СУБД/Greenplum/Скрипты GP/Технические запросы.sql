SELECT * FROM pg_catalog.gp_segment_configuration ORDER BY 1; -- Просмотр конфигурации кластера.

SELECT * FROM a_merkulov_psb.determinate_skew; -- Распределение строк таблицы по сегментам кластера.

SELECT * FROM a_merkulov_psb.blocked_sessions; -- Просмотр блокировок.

SELECT * FROM pg_catalog.pg_locks; -- Просмотр блокировок.

SELECT * FROM pg_catalog.pg_stat_activity

SELECT * FROM pg_catalog.pg_settings; -- Настройки instance.

SELECT * FROM a_merkulov_psb.determinate_skew; -- Представление для просмотра перекоса - нужно менять table_name DDL.

SELECT analyzedb('-d gpdb') -- Запуск сбора статистики с помощью analyzedb по всей БД.

SELECT gp_segment_id, * FROM a_merkulov_psb.test_table; -- Расположение строк таблицы на сегментах.

SELECT pg_total_relation_size('a_merkulov_psb.test_table'); -- Размер одной таблицы.
SELECT pg_size_pretty(pg_total_relation_size('a_merkulov_psb.test_table')) AS total_size; -- Размер одной таблицы в kB.
SELECT pg_size_pretty(pg_relation_size('a_merkulov_psb.test_table')) AS table_size; -- Размер только таблицы без индексов.
SELECT pg_size_pretty(pg_indexes_size('a_merkulov_psb.test_table')) AS indexes_size; -- - Размер только индексов.

SELECT
    table_name,
    pg_size_pretty(pg_total_relation_size(quote_ident(table_schema) || '.' || quote_ident(table_name))) AS total_size
FROM
    information_schema.tables
WHERE
    table_schema = 'a_merkulov_psb'; -- Просмотр полного размера всех таблиц в схеме.
    
SELECT * FROM gp_toolkit.gp_bloat_diag; -- Просмотр раздувания таблиц.


-- Просмотр даты и времени последней проведённой операции VACUUM.
select
       pn.nspname
       ,pc.relname
       ,pslo.staactionname
       ,pslo.stasubtype
       ,pslo.statime as action_date
       ,pp.partitionrangestart
 from pg_stat_last_operation pslo
 right outer join pg_class pc
                on pc.oid = pslo.objid and pslo.staactionname in ('VACUUM')
             join pg_namespace pn
                on pn.oid = pc.relnamespace
         left join pg_catalog.pg_partitions pp
                on (pp.partitiontablename = pc.relname 
                    and pp.schemaname = pn.nspname)
 where pc.relkind IN ('r','s')
   and pc.relstorage IN ('h', 'a', 'c')
   and relname like 'customer_sbrf_cash_m%'
   and pn.nspname = 'mart_agg'
order by partitionrangestart desc

VACUUM a_merkulov_psb.test_table; -- VACUUM таблицы.

-- VACUUM для всх таблиц в схеме. 
DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN 
        SELECT table_schema, table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'a_merkulov_psb' 
          AND table_type = 'BASE TABLE'  -- фильтруем только таблицы
    LOOP
        EXECUTE 'VACUUM ' || quote_ident(r.table_schema) || '.' || quote_ident(r.table_name);
    END LOOP;
END $$;


WITH size_info AS (
    SELECT 
        pg_database_size(current_database()) AS total_size,
        pg_total_relation_size('pg_catalog.pg_tables') AS used_size
)
SELECT 
    pg_size_pretty(total_size) AS total_disk_space,
    pg_size_pretty(used_size) AS used_disk_space,
    pg_size_pretty(total_size - used_size) AS free_disk_space
FROM 
    size_info;
    
   