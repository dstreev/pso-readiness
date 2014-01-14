-- Load Managed Tables;

LOAD DATA LOCAL INPATH '/vagrant/pso_dev_102_hive/data/ml-10M100K/movies.dat' OVERWRITE INTO TABLE dev_102.movies;
LOAD DATA LOCAL INPATH '/vagrant/pso_dev_102_hive/data/ml-10M100K/rating.dat' OVERWRITE INTO TABLE dev_102.ratings;
LOAD DATA LOCAL INPATH '/vagrant/pso_dev_102_hive/data/ml-10M100K/tags.dat' OVERWRITE INTO TABLE dev_102.tags;
