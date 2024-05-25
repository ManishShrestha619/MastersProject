SELECT PARTITION_NAME, TABLE_ROWS FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_NAME = 'emp_replica';  

select distinct partition_flag, count(partition_flag) from test1 group by partition_flag; -- 4947697
select distinct partition_flag, count(partition_flag) from  replica group by partition_flag; -- 4947697
select distinct partition_flag, count(partition_flag) from emp_replica group by partition_flag;

drop table if exists test1;
drop table if exists replica;
drop table if exists emp_replica;
drop table if exists change_tracker;

drop INDEX idx_total_destinations ON test1;
drop INDEX idx_active_routes ON test1;
drop INDEX idx_safety_rating ON test1;
drop INDEX idx_on_time_performance ON test1;
drop INDEX idx_checked_bag_fee ON test1;
drop INDEX idx_carry_on_fee ON test1;
drop INDEX idx_website_url ON test1;
drop INDEX idx_hub_airport ON test1;
drop INDEX idx_alliance_membership ON test1;
drop INDEX idx_headquarters ON test1;













