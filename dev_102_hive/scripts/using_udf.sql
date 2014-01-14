use dev_102;

ADD JAR /vagrant/pso_dev_102_hive/target/dev.102-1.0-SNAPSHOT.jar;

CREATE TEMPORARY FUNCTION Upper102
        AS 'com.hortonworks.pso.readiness.dev102.Upper102';
        
select Upper102(m.title) from movies m limit 10;