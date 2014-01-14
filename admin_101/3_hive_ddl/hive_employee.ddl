CREATE DATABASE IF NOT EXISTS employee;
-- Drop Database with content:
-- DROP database x CASCADE;

USE employee;

-- Prevents the creation of a local derby database for statistics.  May see this when running Oozie jobs on a cluster.
--    which will require the derby jar file if not suppressed.
-- https://cwiki.apache.org/confluence/display/Hive/StatsDev#StatsDev-Usage
set hive.stats.autogather=false;

CREATE EXTERNAL TABLE IF NOT EXISTS departments_ext (
    dept_no     STRING,
    dept_name   STRING
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LOCATION '/user/vagrant/employee_db/departments';

-- Create internal table from external table (different format and create via select)
CREATE TABLE IF NOT EXISTS departments 
STORED as orc tblproperties ("orc.compress"="ZLIB")
AS SELECT * FROM departments_ext;

CREATE EXTERNAL TABLE IF NOT EXISTS employees_ext (
    emp_no      INT,
    birth_date  DATE,
    first_name  STRING,
    last_name   STRING,
    gender      STRING,    
    hire_date   DATE
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LOCATION '/user/vagrant/employee_db/employees';

CREATE TABLE IF NOT EXISTS employees 
STORED as orc tblproperties ("orc.compress"="ZLIB")
AS SELECT * FROM employees_ext;

CREATE EXTERNAL TABLE IF NOT EXISTS dept_manager_ext (
   dept_no      STRING,
   emp_no       INT,
   from_date    DATE,
   to_date      DATE
) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LOCATION '/user/vagrant/employee_db/dept_manager';

CREATE TABLE IF NOT EXISTS dept_manager 
STORED as orc tblproperties ("orc.compress"="ZLIB")
AS SELECT * FROM dept_manager_ext;

CREATE EXTERNAL TABLE IF NOT EXISTS dept_emp_ext (
    emp_no      INT,
    dept_no     STRING,
    from_date   DATE,
    to_date     DATE
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LOCATION '/user/vagrant/employee_db/dept_emp';

CREATE TABLE IF NOT EXISTS dept_emp 
STORED as orc tblproperties ("orc.compress"="ZLIB")
AS SELECT * FROM dept_emp_ext;

CREATE EXTERNAL TABLE IF NOT EXISTS titles_ext (
    emp_no      INT,
    title       STRING,
    from_date   DATE,
    to_date     DATE
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LOCATION '/user/vagrant/employee_db/titles';

CREATE TABLE IF NOT EXISTS titles 
STORED as orc tblproperties ("orc.compress"="ZLIB")
AS SELECT * FROM titles_ext;

CREATE EXTERNAL TABLE IF NOT EXISTS salaries_ext (
    emp_no      INT,
    salary      INT,
    from_date   DATE,
    to_date     DATE
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LOCATION '/user/vagrant/employee_db/salaries';

CREATE TABLE IF NOT EXISTS salaries 
STORED as orc tblproperties ("orc.compress"="ZLIB")
AS SELECT * FROM salaries_ext;
