register '../target/pig.udf-1.0-SNAPSHOT.jar';
define camal com.hortonworks.pso.readiness.dev101.Camal();

data = load 'pso-dev-101/data/$SSN_FILE' using PigStorage
(',')
  as (state:chararray,state_abbreviation:chararray, five_digit_fips:chararray, two_digit_fips:chararray,
  retired_workers_and_dependents:float, survivors:float, disabled_workers_and_dependents:float,
  payments_retired_workers_and_dependents:float, payments_survivors:float,
  payments_disabled_workers_and_dependents:float);

--find year record
yearRecord = filter data by TRIM(state_abbreviation) matches 'total.*';

-- isolate year value
year = foreach yearRecord generate (int)TRIM((chararray)(REPLACE(state,'\\"',''))) as (year:int);
yearOne =  limit year 1;

-- Find States
statesOnly = filter data by TRIM(state_abbreviation) matches '[A-Z]{2}|Abroad';

-- Cartesian Join.
mixed = cross year, statesOnly;
store mixed into 'pso-dev-101/results/$SSN_FILE.out' using PigStorage(',');


-- Apply New UDF to Results.
fixed = foreach mixed generate year::year, camal(statesOnly::state);

store fixed into 'pso-dev-101/results/$SSN_FILE.camal' using PigStorage(',');
