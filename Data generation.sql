-- Assume the "airline" table is already created

-- Use a loop to insert 100,000 rows
DELIMITER //
-- DROP PROCEDURE IF EXISTS InsertAirlineDatas;
-- Your procedure definition

CREATE PROCEDURE InsertAirlineDatas(i int, j int) 
BEGIN
    DECLARE counter INT DEFAULT 0;

    WHILE counter > i and counter<j DO
        INSERT INTO test1 (
			airline_id,
            airline_name,
            headquarters,
            iata_code,
            icao_code,
            founding_year,
            fleet_size,
            website_url,
            contact_email,
            contact_phone,
            CEO_name,
            founding_country,
            alliance_membership,
            frequent_flyer_program,
            hub_airport,
            membership_status,
            stock_symbol,
            revenue,
            net_income,
            total_destinations,
            active_routes,
            safety_rating,
            on_time_performance,
            customer_satisfaction,
            checked_bag_fee,
            carry_on_fee,
            wifi_available,
            inflight_entertainment,
            business_class_offered,
            record_added_date,
            partition_flag
        ) VALUES (
			counter+1,
            CONCAT('Airline', FLOOR(counter / 1000)), -- Portion of counter used for duplicating data
            CONCAT('Headquarters', counter),
            CONCAT('IAT', counter),
            CONCAT('ICA', counter),
            1960 + RAND() * 70,
            FLOOR(RAND() * 500),
            CONCAT('http://www.airline_int', counter, '.com'),
            CONCAT('contact', counter, '@airline2.com'),
            CONCAT('+1 555-', LPAD(counter, 4, '0')),
            CONCAT('CEO', counter),
            CONCAT('Country', counter),
            CONCAT('Alliance', counter),
            CONCAT('Frequent Flyer Program', counter),
            CONCAT('Airport', counter),
            RAND() > 0.5,
            CONCAT('STK', counter),
            RAND() * 1000000000,
            RAND() * 500000000,
            FLOOR(RAND() * 500),
            FLOOR(RAND() * 200),
            RAND(),
            RAND(),
            RAND(),
            RAND() * 50,
            RAND() * 20,
            RAND() > 0.5,
            RAND() > 0.5,
            RAND() > 0.5,
            CURDATE() - INTERVAL FLOOR(RAND() * 365) DAY,
            'TEST'
        );

        SET counter = counter + 1;
    END WHILE;
END;


//
DELIMITER ;


ALTER TABLE test1 MODIFY COLUMN airline_id INT AUTO_INCREMENT PRIMARY KEY;

select * from test1 order by 1 desc;

-- Add a new primary key constraint including both columns
ALTER TABLE test1 ADD PRIMARY KEY (airline_id, partition_flag);


-- Call the stored procedure to insert data
CALL InsertAirlineDatas(100000);
CALL InsertAirlineDatas(100000, 200001);
CALL InsertAirlineDatas();
CALL InsertAirlineDatas();
CALL InsertAirlineDatas();
CALL InsertAirlineDatas();
CALL InsertAirlineDatas();
CALL InsertAirlineDatas();
CALL InsertAirlineDatas();
CALL InsertAirlineDatas();
CALL InsertAirlineDatas();
CALL InsertAirlineDatas();
CALL InsertAirlineDatas();
CALL InsertAirlineDatas();
CALL InsertAirlineDatas();
CALL InsertAirlineDatas();

select count(*) from test1;
commit;

use test;

