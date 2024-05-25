set profiling=1;
-- Determine the number of rows to delete (approximately 10%)
SET @total_rows = (SELECT COUNT(*) FROM test1);
SET @rows_to_delete = ROUND(@total_rows * 0.1);

-- Delete approximately 10% of the rows
SET @delete_sql = CONCAT("update test1 set partition_flag='Archive' LIMIT ", @rows_to_delete);
PREPARE stmt FROM @delete_sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
show PROFILES;

rollback;

-- select sum(duration) as totalduration from information_schema.profiling where query_id>1;
select sum(duration) as totalduration from information_schema.profiling;



select partition_flag, count(partition_flag) from test1 group by partition_flag;


set profiling=1;
-- Determine the number of rows to delete (approximately 50%)
SET @total_rows = (SELECT COUNT(*) FROM test1);
SET @rows_to_delete = ROUND(@total_rows * 0.9);

-- Delete approximately 50% of the rows
SET @delete_sql = CONCAT("update test1 set partition_flag='Keep' where partition_flag is null LIMIT ", @rows_to_delete);
PREPARE stmt FROM @delete_sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
show PROFILES;

-- select sum(duration) as totalduration from information_schema.profiling where query_id>1;
select sum(duration) as totalduration from information_schema.profiling;

commit;

------------------------ DELETE ---------------------------

set profiling=1;
-- Determine the number of rows to delete (approximately 50%)
SET @total_rows = (SELECT COUNT(*) FROM test1);
SET @rows_to_delete = ROUND(@total_rows * 0.9);

-- Delete approximately 50% of the rows
SET @delete_sql = CONCAT("DELETE FROM test1 where partition_flag='Archive' LIMIT ", @rows_to_delete);
PREPARE stmt FROM @delete_sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
show PROFILES;



rollback;
 
commit;

-- select sum(duration) as totalduration from information_schema.profiling where query_id>1;
select sum(duration) as totalduration from information_schema.profiling;
select * from information_schema.profiling;

drop table test1;
create table test1 select * from mainTable;
rollback;

select partition_flag, count(partition_flag) from test1 group by partition_flag;
select partition_flag, count(partition_flag) from replica group by partition_flag;
select partition_flag, count(partition_flag) from emp_replica group by partition_flag;

use test;






