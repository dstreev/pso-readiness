create database IF NOT EXISTS ${DATABASE};

use ${DATABASE};

DROP TABLE users_staging;
CREATE EXTERNAL TABLE IF NOT EXISTS users_staging (
ID INT,
FIRST_NAME STRING,
LAST_NAME STRING,
STATE_CODE STRING,
CITY STRING,
ZIPCODE STRING
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ","
LOCATION "${USERS_DIR}";

DROP TABLE users;
CREATE TABLE IF NOT EXISTS users (
ID INT,
FIRST_NAME STRING,
LAST_NAME STRING,
STATE_CODE STRING,
CITY STRING,
ZIPCODE STRING
)
STORED as orc tblproperties ("orc.compress"="ZLIB");

DROP TABLE states_staging;
CREATE EXTERNAL TABLE IF NOT EXISTS states_staging (
  state string,
  state_code string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ","
LOCATION "${STATES_DIR}";

DROP TABLE states;
CREATE TABLE IF NOT EXISTS states (
  state string,
  state_code string)
STORED as orc tblproperties ("orc.compress"="ZLIB");