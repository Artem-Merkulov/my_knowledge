DROP TABLE IF EXISTS join_traning.table1;
DROP TABLE IF EXISTS join_traning.table2;

CREATE TABLE join_traning.table1 (
	pk1 int4 NULL,
	value1 text NULL
);

CREATE TABLE join_traning.table2 (
	pk2_1 int4 NULL,
	pk2_2 int4 NULL,
	value2 text NULL
);

INSERT INTO join_traning.table1(pk1, value1)
VALUES 
(1, 'One'),
(2, 'Two'),
(3, 'Three'),
(4, 'Four'),
(5, 'Five');

INSERT INTO join_traning.table2(pk2_1, pk2_2 value2)
VALUES 
(1, NULL, 'One'),
(2, NULL,'Two'),
(3, NULL,'Three'),
(NULL, 4, 'Four'),
(NULL, 5, 'Five');

SELECT 
	t1.pk1, 
    t1.value1,
  	t2.pk2_1, 
   	t2.pk2_2, 
   	t2.value2
FROM 
	join_traning.table1 t1
LEFT JOIN 
	join_traning.table2 t2
	ON t1.pk1 = t2.pk2_1 OR t1.pk1 = t2.pk2_2;
	
SELECT 
	t1.pk1, 
    t1.value1,
  	t2.pk2_1, 
   	t2.pk2_2, 
   	t2.value2
FROM 
	join_traning.table2 t2
LEFT JOIN 
	join_traning.table1 t1
	ON t2.pk2_1 = t1.pk1 OR t2.pk2_2 = t1.pk1;