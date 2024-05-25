create table test1 as select * from backup_maintable1;

update test1 set partition_flag='Test';
--------------------------------------------------------------------------------------------------
set profiling=1;
SET @total_rows = (SELECT COUNT(*) FROM test1);
SET @rows_to_delete = ROUND(@total_rows * 0.5);
-- SET @delete_sql = CONCAT("update test1 set partition_flag='Keep' where partition_flag is null LIMIT ", @rows_to_delete);
SET @delete_sql = CONCAT("update test1 set partition_flag='Archive' LIMIT ", @rows_to_delete);
PREPARE stmt FROM @delete_sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
show PROFILES;
----------------
set profiling=1;
SET @total_rows = (SELECT COUNT(*) FROM test1);
SET @rows_to_delete = ROUND(@total_rows * 0.4);
-- SET @delete_sql = CONCAT("update test1 set partition_flag='Keep' where partition_flag is null LIMIT ", @rows_to_delete);
SET @delete_sql = CONCAT("update test1 set partition_flag='Archive' where partition_flag='Test'  LIMIT ", @rows_to_delete);
PREPARE stmt FROM @delete_sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
show PROFILES;
----------------
------------------------------------------------------------------------------------------------------
set profiling=1;
SET @total_rows = (SELECT COUNT(*) FROM test1);
SET @rows_to_delete = ROUND(@total_rows * 0.1);
-- SET @delete_sql = CONCAT("update test1 set partition_flag='Keep' where partition_flag is null LIMIT ", @rows_to_delete);
SET @delete_sql = CONCAT("update test1 set partition_flag='Keep' where partition_flag='Test' LIMIT ", @rows_to_delete);
PREPARE stmt FROM @delete_sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
show PROFILES;


------------------------------------------------------------------------------------------------------

alter table test1 add  PRIMARY KEY (airline_id, partition_flag);

CREATE INDEX idx_airline_name ON test1 (airline_name);
CREATE INDEX idx_iata_code ON test1 (iata_code);
CREATE INDEX idx_icao_code ON test1 (icao_code);
CREATE INDEX idx_founding_year ON test1 (founding_year);
CREATE INDEX idx_date_established ON test1 (date_established);
CREATE INDEX idx_founding_country ON test1 (founding_country);
CREATE INDEX idx_CEO_name ON test1 (CEO_name);
CREATE INDEX idx_stock_symbol ON test1 (stock_symbol);
CREATE INDEX idx_customer_satisfaction ON test1 (customer_satisfaction);

CREATE INDEX idx_total_destinations ON test1 (total_destinations);
CREATE INDEX idx_active_routes ON test1 (active_routes);
CREATE INDEX idx_safety_rating ON test1 (safety_rating);
CREATE INDEX idx_on_time_performance ON test1 (on_time_performance);
CREATE INDEX idx_checked_bag_fee ON test1 (checked_bag_fee);
CREATE INDEX idx_carry_on_fee ON test1 (carry_on_fee);
CREATE INDEX idx_website_url ON test1 (website_url);
CREATE INDEX idx_hub_airport ON test1 (hub_airport);
CREATE INDEX idx_alliance_membership ON test1 (alliance_membership);
CREATE INDEX idx_headquarters ON test1 (headquarters);



