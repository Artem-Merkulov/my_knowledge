SELECT name, value, display_value 
FROM v$parameter 
WHERE name = 'statistics_level';
/*
NAME            |VALUE  |DISPLAY_VALUE|
----------------+-------+-------------+
statistics_level|TYPICAL|TYPICAL      |
*/

SELECT name, value, display_value 
FROM v$system_parameter 
WHERE name = 'statistics_level';
/*
NAME            |VALUE  |DISPLAY_VALUE|
----------------+-------+-------------+
statistics_level|TYPICAL|TYPICAL      |
*/

SELECT inst_id, name, value, display_value 
FROM gv$parameter 
WHERE name = 'tracefile_identifier';
/*
INST_ID|NAME                |VALUE|DISPLAY_VALUE|
-------+--------------------+-----+-------------+
      1|tracefile_identifier|     |             |
*/

SELECT inst_id, name, value, display_value 
FROM gv$parameter 
WHERE name = '_sqlmon_max_plan';
/*
INST_ID|NAME|VALUE|DISPLAY_VALUE|
-------+----+-----+-------------+|
*/


-- Включите трассировку (не обязательно, но дает больше данных)
ALTER SESSION SET STATISTICS_LEVEL = TYPICAL;

ALTER SESSION SET tracefile_identifier = 'my_trace';

ALTER SESSION SET "_sqlmon_max_plan" = 100;


SELECT name, value, display_value 
FROM v$parameter 
WHERE name = 'statistics_level';
/*
NAME            |VALUE|DISPLAY_VALUE|
----------------+-----+-------------+
statistics_level|ALL  |ALL          |
*/

SELECT inst_id, name, value, display_value 
FROM gv$parameter 
WHERE name = 'tracefile_identifier';
/*
INST_ID|NAME                |VALUE   |DISPLAY_VALUE|
-------+--------------------+--------+-------------+
      1|tracefile_identifier|my_trace|my_trace     |
*/

SELECT inst_id, name, value, display_value 
FROM gv$parameter 
WHERE name = '_sqlmon_max_plan';
/*
INST_ID|NAME            |VALUE|DISPLAY_VALUE|
-------+----------------+-----+-------------+
      1|_sqlmon_max_plan|100  |100          |
*/


-- Сбор статистики
EXPLAIN PLAN FOR

WITH
source_data AS (
  SELECT
    A,
    B,
    C
  FROM
    UCB_TEST.RANDOM_VALUES
),
concat_data AS (
  SELECT
    RAWTOHEX(STANDARD_HASH(COALESCE(NULLIF(TRIM(TO_CHAR(A)), ''), '^^'), 'SHA256')) || '||' ||
    RAWTOHEX(STANDARD_HASH(COALESCE(NULLIF(TRIM(TO_CHAR(B)), ''), '^^'), 'SHA256')) || '||' ||
    RAWTOHEX(STANDARD_HASH(COALESCE(NULLIF(TRIM(TO_CHAR(C)), ''), '^^'), 'SHA256')) concat_string
  FROM
    source_data
),
hashed_data AS (
  SELECT
    RAWTOHEX(STANDARD_HASH(concat_string, 'SHA256')) hashed_val
  FROM
    concat_data
)
SELECT * FROM hashed_data;


-- Просматриваем план с стоимостью
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY(format => 'TYPICAL +COST'));
/*
PLAN_TABLE_OUTPUT                                                                  |
-----------------------------------------------------------------------------------+
Plan hash value: 4111898099                                                        |
                                                                                   |
-----------------------------------------------------------------------------------|
| Id  | Operation         | Name          | Rows  | Bytes | Cost (%CPU)| Time     ||
-----------------------------------------------------------------------------------|
|   0 | SELECT STATEMENT  |               |    10 |   117K|    11   (0)| 00:00:01 ||
|   1 |  TABLE ACCESS FULL| RANDOM_VALUES |    10 |   117K|    11   (0)| 00:00:01 ||
-----------------------------------------------------------------------------------|
*/


-- Найдите ваш запрос
SELECT DISTINCT sql_id, sql_text FROM v$sql 
WHERE sql_text LIKE '%Сбор статистики%';
/*
SQL_ID       |SQL_TEXT                                                                                                                                                                                                                                                       |
-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
cqwtbjzg9scjp|-- Найдите ваш запрос SELECT sql_id, sql_text FROM v$sql  WHERE sql_text LIKE '%Сбор статистики%'                                                                                                                                                              |
7na676ruyja64|-- Сбор статистики WITH source_data AS (   SELECT     A,     B,     C   FROM     UCB_TEST.RANDOM_VALUES ), concat_data AS (   SELECT     RAWTOHEX(STANDARD_HASH(COALESCE(NULLIF(TRIM(TO_CHAR(A)), ''), '^^'), 'SHA256')) || '||' ||     RAWTOHEX(STANDARD_HASH(|
*/


-- Получите план с фактической статистикой
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(null, null, 'ALLSTATS LAST +COST'));



SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(
  sql_id        => '7na676ruyja64', 
  cursor_child_no => NULL, 
  format        => 'ALLSTATS LAST +COST +ROWS +BYTES'
));
/*
PLAN_TABLE_OUTPUT                                                                                                 |
------------------------------------------------------------------------------------------------------------------+
SQL_ID  7na676ruyja64, child number 0                                                                             |
-------------------------------------                                                                             |
-- Сбор статистики WITH source_data AS (   SELECT     A,     B,                                                   |
  C   FROM     UCB_TEST.RANDOM_VALUES ), concat_data AS (                                                         |
SELECT     RAWTOHEX(STANDARD_HASH(COALESCE(NULLIF(TRIM(TO_CHAR(A)),                                               |
''), '^^'), 'SHA256')) || '||' ||                                                                                 |
RAWTOHEX(STANDARD_HASH(COALESCE(NULLIF(TRIM(TO_CHAR(B)), ''), '^^'),                                              |
'SHA256')) || '||' ||     RAWTOHEX(STANDARD_HASH(COALESCE(NULLIF(TRIM(T                                           |
O_CHAR(C)), ''), '^^'), 'SHA256')) concat_string   FROM                                                           |
source_data ), hashed_data AS (   SELECT                                                                          |
RAWTOHEX(STANDARD_HASH(concat_string, 'SHA256')) hashed_val   FROM                                                |
 concat_data ) SELECT * FROM hashed_data                                                                          |
                                                                                                                  |
Plan hash value: 4111898099                                                                                       |
                                                                                                                  |
------------------------------------------------------------------------------------------------------------------|
| Id  | Operation         | Name          | Starts | E-Rows |E-Bytes| Cost (%CPU)| A-Rows |   A-Time   | Buffers ||
------------------------------------------------------------------------------------------------------------------|
|   0 | SELECT STATEMENT  |               |      1 |        |       |    11 (100)|     10 |00:00:00.01 |      57 ||
|   1 |  TABLE ACCESS FULL| RANDOM_VALUES |      1 |     10 |   117K|    11   (0)|     10 |00:00:00.01 |      57 ||
------------------------------------------------------------------------------------------------------------------|                                                                                              |
*/

-- Получите отчет мониторинга
SELECT DBMS_SQLTUNE.REPORT_SQL_MONITOR(
  sql_id => '7na676ruyja64',
  type => 'TEXT',
  report_level => 'ALL') AS report
FROM dual;
/*
REPORT               |
---------------------+
SQL Monitoring Report|
*/