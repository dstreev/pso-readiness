#!/bin/bash

# Load the Employee Data into MySQL.
# Run from a server with a MySQL instance running. IE: Hive Server.

cd `dirname $0`

mysql -uroot < mysql_user_create.sh

cd ../../../../data/employees_db

# Create User for Database

mysql -uvagrant -pvagrant < employees.sql


