create database dev_102_ext;
create database dev_102;

use dev_102_ext;

drop table movies;
create external table movies (
id int,
title string,
genres ARRAY<string>
)
ROW FORMAT DELIMITED
  FIELDS TERMINATED BY ':'
  COLLECTION ITEMS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/user/vagrant/pso-dev-102/external/movies';

drop table ratings;
create external table ratings (
userid int,
movieid int,
rating string,
ts bigint
)
ROW FORMAT DELIMITED
  FIELDS TERMINATED BY ':'
STORED AS TEXTFILE
LOCATION '/user/vagrant/pso-dev-102/external/ratings';

drop table tags;
create external table tags (
userid int,
movieid int,
tag string,
ts bigint
)
ROW FORMAT DELIMITED
  FIELDS TERMINATED BY ':'
STORED AS TEXTFILE
LOCATION '/user/vagrant/pso-dev-102/external/tags';

use dev_102;

drop table movies;
create table movies (
id int,
title string,
genres ARRAY<string>
)
ROW FORMAT DELIMITED
  FIELDS TERMINATED BY ':'
  COLLECTION ITEMS TERMINATED BY '|'
STORED AS TEXTFILE;

drop table ratings;
create table ratings (
userid int,
movieid int,
rating string,
ts bigint
)
ROW FORMAT DELIMITED
  FIELDS TERMINATED BY ':'
STORED AS TEXTFILE;

drop table tags;
create table tags (
userid int,
movieid int,
tag string,
ts bigint
)
ROW FORMAT DELIMITED
  FIELDS TERMINATED BY ':'
STORED AS TEXTFILE;