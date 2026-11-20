CREATE TABLE source_table (id INT PRIMARY KEY, descr TEXT);


CREATE TABLE target_table (LIKE source_table INCLUDING ALL);


INSERT INTO test.source_table VALUES
(0, 'Ноль'),
(1, 'Один'),
(2, 'Два');


INSERT INTO target_table SELECT * FROM source_table;


SELECT * FROM test.source_table;


SELECT * FROM target_table tt ORDER BY id;


UPDATE target_table SET descr = '';


SELECT s.*, t.*
FROM source_table s
FULL OUTER JOIN target_table t ON (t.id = s.id);


MERGE INTO target_table t
USING source_table s ON t.id = s.id
WHEN MATCHED THEN
UPDATE SET descr = s.descr;


SELECT s.*, t.*
FROM source_table s
FULL OUTER JOIN target_table t ON (t.id = s.id);


EXPLAIN(COSTS OFF)
MERGE INTO target_table t
USING source_table s ON t.id = s.id
WHEN MATCHED THEN
UPDATE SET descr = s.descr;

/*WHEN MATCHED - строки есть и в источнике и в целевой таблице
 * WHEN MATCHED - строки есть в источнике, но их нет в целевой таблице.*/


-- Аналог UPDATE 
UPDATE target_table t
SET descr = s.descr
FROM source_table s
WHERE t.id = s.id;


SELECT s.*, t.*
FROM source_table s
FULL OUTER JOIN target_table t ON (t.id = s.id);


DELETE FROM target_table WHERE id = 0;


SELECT s.*, t.*
FROM source_table s
FULL OUTER JOIN target_table t ON (t.id = s.id);


MERGE INTO target_table t
USING source_table s ON t.id = s.id
WHEN NOT MATCHED THEN
INSERT (id, descr) VALUES(s.id, s.descr)
WHEN MATCHED THEN
UPDATE SET descr = s.descr;


SELECT s.*, t.*
FROM source_table s
FULL OUTER JOIN target_table t ON (t.id = s.id);


EXPLAIN--(COSTS OFF)
MERGE INTO target_table t
USING source_table s ON t.id = s.id
WHEN NOT MATCHED THEN
INSERT (id, descr) VALUES(s.id, s.descr)
WHEN MATCHED THEN
UPDATE SET descr = s.descr;


-- Аналог INSERT
EXPLAIN--(COSTS OFF)
INSERT INTO target_table 
SELECT * FROM source_table s
ON CONFLICT (id) 
DO UPDATE SET descr = EXCLUDED.descr;


INSERT INTO test.target_table VALUES
(3, 'Три');


SELECT s.*, t.*
FROM source_table s
FULL OUTER JOIN target_table t ON (t.id = s.id);


SELECT COALESCE(s.id, t.id) full_id, s.*
FROM source_table s
FULL OUTER JOIN target_table t ON t.id = s.id;


MERGE INTO target_table t
USING (
    SELECT COALESCE(s.id, t.id) full_id, s.*
    FROM source_table s
    FULL OUTER JOIN target_table t ON t.id = s.id
 ) s ON t.id = s.full_id
WHEN NOT MATCHED THEN 
    INSERT (id, descr) VALUES(s.id, s.descr)
WHEN MATCHED AND s.id IS NULL THEN 
    DELETE 
WHEN MATCHED THEN 
    UPDATE SET descr = s.descr;
    
   
SELECT s.*, t.*
FROM source_table s
FULL OUTER JOIN target_table t ON (t.id = s.id);


EXPLAIN (ANALYZE, costs OFF, timing OFF, summary off)
MERGE INTO target_table t
USING (
    SELECT COALESCE(s.id, t.id) full_id, s.*
    FROM source_table s
    FULL OUTER JOIN target_table t ON t.id = s.id
 ) s ON t.id = s.full_id
WHEN NOT MATCHED THEN 
    INSERT (id, descr) VALUES(s.id, s.descr)
WHEN MATCHED AND s.id IS NULL THEN 
    DELETE 
WHEN MATCHED THEN 
    UPDATE SET descr = s.descr;
