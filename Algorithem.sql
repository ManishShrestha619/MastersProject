----------------------------- ALGORITHM --------------------------------------
set profiling=1;
-- STEP 1: CREATE A NEW REPLICA OF A TABLE. EMPTY ONE.
drop table if exists replica;

CREATE TABLE replica (
    airline_id INT AUTO_INCREMENT,
    airline_name VARCHAR(100) NOT NULL,
    headquarters VARCHAR(100),
    iata_code VARCHAR(10),
    icao_code VARCHAR(10),
    founding_year INT,
    date_established DATE,
    fleet_size INT,
    website_url VARCHAR(255),
    contact_email VARCHAR(100),
    contact_phone VARCHAR(20),
    CEO_name VARCHAR(100),
    founding_country VARCHAR(50),
    alliance_membership VARCHAR(50),
    frequent_flyer_program VARCHAR(100),
    hub_airport VARCHAR(100),
    membership_status BOOLEAN,
    stock_symbol VARCHAR(10),
    revenue DECIMAL(15, 2),
    net_income DECIMAL(15, 2),
    total_destinations INT,
    active_routes INT,
    safety_rating FLOAT,
    on_time_performance FLOAT,
    customer_satisfaction FLOAT,
    checked_bag_fee DECIMAL(5, 2),
    carry_on_fee DECIMAL(5, 2),
    wifi_available BOOLEAN,
    inflight_entertainment BOOLEAN,
    business_class_offered BOOLEAN,
    record_added_date TIMESTAMP,
    partition_flag varchar(10),
    PRIMARY KEY (airline_id, partition_flag)
)
PARTITION BY LIST columns (partition_flag) (
    PARTITION keep_partition VALUES IN ('keep'),
    PARTITION archive_partition VALUES IN ('archive')
);


-- STEP 2: CREATING A  TRIGGER IN ORIGINAL TABLE

/*
	INSERT TRIGGER STARTS HERE
*/

drop trigger if exists trigger_insert;

DELIMITER //

CREATE TRIGGER trigger_insert
AFTER INSERT ON test1
FOR EACH ROW
BEGIN
    INSERT INTO change_tracker(
        airline_id, airline_name, headquarters, iata_code, icao_code, founding_year, date_established, fleet_size, website_url, contact_email, contact_phone, CEO_name, founding_country, alliance_membership, 
        frequent_flyer_program, hub_airport, membership_status, stock_symbol, revenue, net_income, total_destinations, active_routes, safety_rating, on_time_performance, customer_satisfaction, checked_bag_fee, 
        carry_on_fee, wifi_available, inflight_entertainment, business_class_offered, record_added_date, partition_flag, operation
    )
    VALUES (
        new.airline_id, 
        new.airline_name, 
        new.headquarters, 
        new.iata_code, 
        new.icao_code, 
        new.founding_year, 
        new.date_established, 
        new.fleet_size, 
        new.website_url, 
        new.contact_email, 
        new.contact_phone, 
        new.CEO_name, 
        new.founding_country, 
        new.alliance_membership, 
        new.frequent_flyer_program, 
        new.hub_airport, 
        new.membership_status,
        new.stock_symbol, 
        new.revenue, 
        new.net_income, 
        new.total_destinations, 
        new.active_routes, 
        new.safety_rating, 
        new.on_time_performance, 
        new.customer_satisfaction, 
        new.checked_bag_fee, 
        new.carry_on_fee, 
        new.wifi_available, 
        new.inflight_entertainment, 
        new.business_class_offered, 
        new.record_added_date,
        new.partition_flag,
        'INSERT'
    );
END//

DELIMITER ;

/*
	INSERT TRIGGER ENDS HERE
*/

/*
	UPDATE TRIGGER STARTS HERE
*/

drop trigger if exists trigger_update;

DELIMITER $$

CREATE TRIGGER trigger_update
AFTER UPDATE ON test1
FOR EACH ROW
BEGIN
    IF 
	   OLD.partition_flag='Keep' and	
	   OLD.airline_id <> NEW.airline_id OR
       OLD.airline_name <> NEW.airline_name OR
       OLD.headquarters <> NEW.headquarters OR
       OLD.iata_code <> NEW.iata_code OR
       OLD.icao_code <> NEW.icao_code OR
       OLD.founding_year <> NEW.founding_year OR
       OLD.date_established <> NEW.date_established OR
       OLD.fleet_size <> NEW.fleet_size OR
       OLD.website_url <> NEW.website_url OR
       OLD.contact_email <> NEW.contact_email OR
       OLD.contact_phone <> NEW.contact_phone OR
       OLD.CEO_name <> NEW.CEO_name OR
       OLD.founding_country <> NEW.founding_country OR
       OLD.alliance_membership <> NEW.alliance_membership OR
       OLD.frequent_flyer_program <> NEW.frequent_flyer_program OR
       OLD.hub_airport <> NEW.hub_airport OR
       OLD.membership_status <> NEW.membership_status OR
       OLD.stock_symbol <> NEW.stock_symbol OR
       OLD.revenue <> NEW.revenue OR
       OLD.net_income <> NEW.net_income OR
       OLD.total_destinations <> NEW.total_destinations OR
       OLD.active_routes <> NEW.active_routes OR
       OLD.safety_rating <> NEW.safety_rating OR
       OLD.on_time_performance <> NEW.on_time_performance OR
       OLD.customer_satisfaction <> NEW.customer_satisfaction OR
       OLD.checked_bag_fee <> NEW.checked_bag_fee OR
       OLD.carry_on_fee <> NEW.carry_on_fee OR
       OLD.wifi_available <> NEW.wifi_available OR
       OLD.inflight_entertainment <> NEW.inflight_entertainment OR
       OLD.business_class_offered <> NEW.business_class_offered OR
       OLD.record_added_date <> NEW.record_added_date OR
       OLD.partition_flag <> NEW.partition_flag THEN

        INSERT INTO change_tracker(
            airline_id, airline_name, headquarters, iata_code, icao_code, founding_year, date_established, fleet_size, website_url, contact_email, contact_phone, CEO_name, founding_country, alliance_membership, 
            frequent_flyer_program, hub_airport, membership_status, stock_symbol, revenue, net_income, total_destinations, active_routes, safety_rating, on_time_performance, customer_satisfaction, checked_bag_fee, 
            carry_on_fee, wifi_available, inflight_entertainment, business_class_offered, record_added_date, partition_flag, operation
        )
        VALUES (
            NEW.airline_id, 
            NEW.airline_name, 
            NEW.headquarters, 
            NEW.iata_code, 
            NEW.icao_code, 
            NEW.founding_year, 
            NEW.date_established, 
            NEW.fleet_size, 
            NEW.website_url, 
            NEW.contact_email, 
            NEW.contact_phone, 
            NEW.CEO_name, 
            NEW.founding_country, 
            NEW.alliance_membership, 
            NEW.frequent_flyer_program, 
            NEW.hub_airport, 
            NEW.membership_status,
            NEW.stock_symbol, 
            NEW.revenue, 
            NEW.net_income, 
            NEW.total_destinations, 
            NEW.active_routes, 
            NEW.safety_rating, 
            NEW.on_time_performance, 
            NEW.customer_satisfaction, 
            NEW.checked_bag_fee, 
            NEW.carry_on_fee, 
            NEW.wifi_available, 
            NEW.inflight_entertainment, 
            NEW.business_class_offered, 
            NEW.record_added_date,
            NEW.partition_flag,
	    'UPDATE'
        );
    END IF;
END$$

DELIMITER ;

/*
	UPDATE TRIGGER ENDS HERE
*/

/*
	DELETE TRIGGER STARTS HERE
*/
drop trigger if exists trigger_delete;
DELIMITER $$

CREATE TRIGGER trigger_delete
AFTER DELETE ON test1
FOR EACH ROW
BEGIN
    INSERT INTO change_tracker(
        airline_id, airline_name, headquarters, iata_code, icao_code, founding_year, date_established, fleet_size, website_url, contact_email, contact_phone, CEO_name, founding_country, alliance_membership, 
        frequent_flyer_program, hub_airport, membership_status, stock_symbol, revenue, net_income, total_destinations, active_routes, safety_rating, on_time_performance, customer_satisfaction, checked_bag_fee, 
        carry_on_fee, wifi_available, inflight_entertainment, business_class_offered, record_added_date, partition_flag, operation
    )
    VALUES (
        OLD.airline_id, 
        OLD.airline_name, 
        OLD.headquarters, 
        OLD.iata_code, 
        OLD.icao_code, 
        OLD.founding_year, 
        OLD.date_established, 
        OLD.fleet_size, 
        OLD.website_url, 
        OLD.contact_email, 
        OLD.contact_phone, 
        OLD.CEO_name, 
        OLD.founding_country, 
        OLD.alliance_membership, 
        OLD.frequent_flyer_program, 
        OLD.hub_airport, 
        OLD.membership_status,
        OLD.stock_symbol, 
        OLD.revenue, 
        OLD.net_income, 
        OLD.total_destinations, 
        OLD.active_routes, 
        OLD.safety_rating, 
        OLD.on_time_performance, 
        OLD.customer_satisfaction, 
        OLD.checked_bag_fee, 
        OLD.carry_on_fee, 
        OLD.wifi_available, 
        OLD.inflight_entertainment, 
        OLD.business_class_offered, 
        OLD.record_added_date,
        OLD.partition_flag,
	'DELETE'
    );
END$$

DELIMITER ;
/*
	DELETE TRIGGER ENDS HERE
*/

-- STEP 3: CREATE CHANGE TRACKER
drop table if exists change_tracker;

create table change_tracker as select * from test1 where 1=2;
alter table change_tracker add column operation varchar(20);

-- STEP 4: POPULATING NEAR REPLICA
insert into replica (airline_id, airline_name, headquarters, iata_code, icao_code, founding_year, date_established, fleet_size, website_url, contact_email, contact_phone, CEO_name, founding_country, alliance_membership, frequent_flyer_program, hub_airport, membership_status, stock_symbol, revenue, net_income, total_destinations, active_routes, safety_rating, on_time_performance, customer_satisfaction, checked_bag_fee, carry_on_fee, wifi_available, inflight_entertainment, business_class_offered, record_added_date, partition_flag)
select airline_id, airline_name, headquarters, iata_code, icao_code, founding_year, date_established, fleet_size, website_url, contact_email, contact_phone, CEO_name, founding_country, alliance_membership, frequent_flyer_program, hub_airport, membership_status, stock_symbol, revenue, net_income, total_destinations, active_routes, safety_rating, on_time_performance, customer_satisfaction, checked_bag_fee, carry_on_fee, wifi_available, inflight_entertainment, business_class_offered, record_added_date, partition_flag
from test1 where partition_flag='Keep'; -- 20 sec

insert into replica (airline_id, airline_name, headquarters, iata_code, icao_code, founding_year, date_established, fleet_size, website_url, contact_email, contact_phone, CEO_name, founding_country, alliance_membership, frequent_flyer_program, hub_airport, membership_status, stock_symbol, revenue, net_income, total_destinations, active_routes, safety_rating, on_time_performance, customer_satisfaction, checked_bag_fee, carry_on_fee, wifi_available, inflight_entertainment, business_class_offered, record_added_date, partition_flag)
select airline_id, airline_name, headquarters, iata_code, icao_code, founding_year, date_established, fleet_size, website_url, contact_email, contact_phone, CEO_name, founding_country, alliance_membership, frequent_flyer_program, hub_airport, membership_status, stock_symbol, revenue, net_income, total_destinations, active_routes, safety_rating, on_time_performance, customer_satisfaction, checked_bag_fee, carry_on_fee, wifi_available, inflight_entertainment, business_class_offered, record_added_date, partition_flag
from test1 where partition_flag='Archive'; -- 19 sec

-- CREATE EMPTY TABLE 
drop table if exists emp_replica;
create table emp_replica like replica;

-- REMOVE PARTITION
ALTER TABLE emp_replica REMOVE PARTITIONING;

-- EXCHANGE PARTITION
ALTER TABLE replica EXCHANGE PARTITION archive_partition WITH TABLE emp_replica;

/* 
CREATING PROCEDURE TO REFLECT CHANGES IN REPLICA 
*/

-- INSERT STORED PROCEDURE
drop procedure if exists sp_insert;
DELIMITER //
CREATE PROCEDURE sp_insert()
BEGIN
    insert into replica 
    select 
		airline_id, airline_name, headquarters, iata_code, icao_code, founding_year, date_established, fleet_size, website_url, contact_email, contact_phone, CEO_name, 
        founding_country, alliance_membership, frequent_flyer_program, hub_airport, membership_status, stock_symbol, revenue, net_income, total_destinations, active_routes, 
        safety_rating, on_time_performance, customer_satisfaction, checked_bag_fee, carry_on_fee, wifi_available, inflight_entertainment, business_class_offered, record_added_date, partition_flag
    from change_tracker where upper(operation)=upper('Insert');
    -- delete from change_tracker where upper(operation)=upper('Insert');
END//
DELIMITER ;

-- UPDATE STORED PROCEDURE
drop procedure if exists sp_update;
DELIMITER //

CREATE PROCEDURE sp_update()
BEGIN
    UPDATE replica AS old
    JOIN change_tracker AS new ON old.airline_id = new.airline_id
    SET
        old.airline_name = new.airline_name,
        old.headquarters = new.headquarters,
        old.iata_code = new.iata_code,
        old.icao_code = new.icao_code,
        old.founding_year = new.founding_year,
        old.date_established = new.date_established,
        old.fleet_size = new.fleet_size,
        old.website_url = new.website_url,
        old.contact_email = new.contact_email,
        old.contact_phone = new.contact_phone,
        old.CEO_name = new.CEO_name,
        old.founding_country = new.founding_country,
        old.alliance_membership = new.alliance_membership,
        old.frequent_flyer_program = new.frequent_flyer_program,
        old.hub_airport = new.hub_airport,
        old.membership_status = new.membership_status,
        old.stock_symbol = new.stock_symbol,
        old.revenue = new.revenue,
        old.net_income = new.net_income,
        old.total_destinations = new.total_destinations,
        old.active_routes = new.active_routes,
        old.safety_rating = new.safety_rating,
        old.on_time_performance = new.on_time_performance,
        old.customer_satisfaction = new.customer_satisfaction,
        old.checked_bag_fee = new.checked_bag_fee,
        old.carry_on_fee = new.carry_on_fee,
        old.wifi_available = new.wifi_available,
        old.inflight_entertainment = new.inflight_entertainment,
        old.business_class_offered = new.business_class_offered,
        old.record_added_date = new.record_added_date,
        old.partition_flag = new.partition_flag
    WHERE
        old.partition_flag = 'Keep' AND new.operation = 'UPDATE' AND
        (old.airline_id <> new.airline_id OR
        old.airline_name <> new.airline_name OR
        old.headquarters <> new.headquarters OR
        old.iata_code <> new.iata_code OR
        old.icao_code <> new.icao_code OR
        old.founding_year <> new.founding_year OR
        old.date_established <> new.date_established OR
        old.fleet_size <> new.fleet_size OR
        old.website_url <> new.website_url OR
        old.contact_email <> new.contact_email OR
        old.contact_phone <> new.contact_phone OR
        old.CEO_name <> new.CEO_name OR
        old.founding_country <> new.founding_country OR
        old.alliance_membership <> new.alliance_membership OR
        old.frequent_flyer_program <> new.frequent_flyer_program OR
        old.hub_airport <> new.hub_airport OR
        old.membership_status <> new.membership_status OR
        old.stock_symbol <> new.stock_symbol OR
        old.revenue <> new.revenue OR
        old.net_income <> new.net_income OR
        old.total_destinations <> new.total_destinations OR
        old.active_routes <> new.active_routes OR
        old.safety_rating <> new.safety_rating OR
        old.on_time_performance <> new.on_time_performance OR
        old.customer_satisfaction <> new.customer_satisfaction OR
        old.checked_bag_fee <> new.checked_bag_fee OR
        old.carry_on_fee <> new.carry_on_fee OR
        old.wifi_available <> new.wifi_available OR
        old.inflight_entertainment <> new.inflight_entertainment OR
        old.business_class_offered <> new.business_class_offered OR
        old.record_added_date <> new.record_added_date OR
        old.partition_flag <> new.partition_flag);
	
	-- delete from change_tracker where upper(operation)=upper('Update');
        
END //

DELIMITER ;

-- DELETE STORED PROCEDURE
drop procedure if exists sp_delete;
DELIMITER //

CREATE PROCEDURE sp_delete()
BEGIN
    delete from replica where airline_id in (
	select airline_id from change_tracker where operation='DELETE' 
);
-- delete from change_tracker where upper(operation)=upper('Delete');
END //

DELIMITER ;

show PROFILES;
select sum(duration) as totalduration from information_schema.profiling;

 -- SET SQL_SAFE_UPDATES = 0;
-- SET autocommit = 0;
-- PURGE BINARY LOGS BEFORE '2024-05-11 hh:mm:ss';

-- rollback;