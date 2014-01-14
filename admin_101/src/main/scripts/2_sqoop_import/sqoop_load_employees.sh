#!/bin/bash

USERNAME=vagrant
PASSWORD=vagrant
# Create Links to find MySQL jdbc drivers.
#sudo mkdir /etc/sqoop/conf/manager.d

# This is one way to get the jdbc jar in the classpath.
# Reference: Sqoop Cookbook page # 4
# MySQL Driver already in Sqoop Directory... but if you need another...
#sudo echo 'com.mysql.jdbc.driver=/usr/lib/hive/lib/mysql-connector-java.jar' > /etc/sqoop/conf/manager.d/mysql.conf

# Clean up previous import
hdfs dfs -rm -r ./departments

# Load Entire Table to HDFS with 1 mapper. ',' separated (default)
sqoop import --connect jdbc:mysql://pm2.hwx.test/employees --username $USERNAME --password $PASSWORD --table departments -m 1

# Load to a specific directory. '|' separated (--fields-terminated-by) NOTE the escape char (\)
hdfs dfs -rm -r -skipTrash ./employee_db

for i in departments dept_manager titles; do
sqoop import --fields-terminated-by \| --connect jdbc:mysql://pm2.hwx.test/employees --username $USERNAME --password $PASSWORD --table $i -m 1 -target-dir ./employee_db/$i
done

for i in dept_emp salaries employees; do
sqoop import --fields-terminated-by \| --connect jdbc:mysql://pm2.hwx.test/employees --username $USERNAME --password $PASSWORD --table $i -m 3 -target-dir ./employee_db/$i
done





