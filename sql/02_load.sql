SHOW VARIABLES LIKE 'local_infile';
   
USE upi_analysis;
   
-- Parent table first, then child tables (foreign keys)
LOAD DATA LOCAL INFILE 'C:/Users/aryan/Desktop/upi-growth-analysis/data/clean/upi_monthly.csv'
INTO TABLE upi_monthly
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(month_date, @banks, volume_mn, value_cr)
SET banks_live = NULLIF(@banks, '');

LOAD DATA LOCAL INFILE 'C:/Users/aryan/Desktop/upi-growth-analysis/data/clean/upi_apps.csv'
INTO TABLE upi_apps
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(month_date, app_name, volume_mn, value_cr);

LOAD DATA LOCAL INFILE 'C:/Users/aryan/Desktop/upi-growth-analysis/data/clean/upi_p2p_p2m.csv'
INTO TABLE upi_p2p_p2m
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(month_date, txn_type, volume_mn, value_cr);