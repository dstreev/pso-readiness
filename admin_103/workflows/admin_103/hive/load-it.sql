use ${database};

INSERT OVERWRITE TABLE ${entity} FROM
SELECT * FROM ${entity}_staging;
