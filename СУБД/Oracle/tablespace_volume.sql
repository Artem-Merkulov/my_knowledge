-- Tablespace volume

SELECT
	df.tablespace_name,
	ROUND((df.max_bytes - df.bytes) / 1024 / 1024) AS free_mb
FROM
	user_tablespaces ut,
	user_ts_quotas df
WHERE
	ut.tablespace_name = df.tablespace_name
ORDER BY
	free_mb DESC;
/*
TABLESPACE_NAME|FREE_MB|
---------------+-------+
USERS          |     -1|
*/

SELECT
	tablespace_name,
	ROUND(total_space_mb) AS total_mb,
	ROUND(free_space_mb) AS free_mb,
	ROUND((free_space_mb / total_space_mb) * 100, 2) AS percent_free
FROM
	(
	SELECT
		ts.tablespace_name,
		ts.bytes / 1024 / 1024 AS total_space_mb,
		NVL(fs.bytes, 0) / 1024 / 1024 AS free_space_mb
	FROM
		(
		SELECT
			tablespace_name,
			SUM(bytes) bytes
		FROM
			dba_data_files
		GROUP BY
			tablespace_name) ts,
		(
		SELECT
			tablespace_name,
			SUM(bytes) bytes
		FROM
			dba_free_space
		GROUP BY
			tablespace_name) fs
	WHERE
		ts.tablespace_name = fs.tablespace_name(+)
)
ORDER BY
	percent_free;
/*
TABLESPACE_NAME|TOTAL_MB|FREE_MB|PERCENT_FREE|
---------------+--------+-------+------------+
SYSTEM         |     310|      3|        1.07|
SYSAUX         |     850|    101|       11.88|
USERS          |    5023|   4880|       97.16|
UNDOTBS1       |    1370|   1351|       98.58|
*/