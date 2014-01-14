use employee;

-- Employees born after Oct 1, 1955.
select * from employees where birth_date > unix_timestamp('1955-10-01', 'yyyy-MM-dd');
