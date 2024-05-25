PURGE BINARY LOGS BEFORE '2024-08-11 hh:mm:ss';

SET SQL_SAFE_UPDATES = 0;
SET autocommit = 0;

use test;

flush tables;

-- In MySQL Workbench
FLUSH TABLES;
FLUSH TABLES WITH READ LOCK;
UNLOCK TABLES;

FLUSH TABLES;
SET GLOBAL innodb_buffer_pool_size = 0;
SET GLOBAL innodb_buffer_pool_size = original_size; -- Replace with actual size
FLUSH TABLES WITH READ LOCK;
UNLOCK TABLES;

SELECT * FROM performance_schema.global_status WHERE VARIABLE_NAME LIKE '%cache%';

SHOW ENGINE INNODB STATUS;
show full processlist;

SELECT * FROM performance_schema.events_statements_current;
SELECT * FROM performance_schema.events_waits_summary_global_by_event_name;




