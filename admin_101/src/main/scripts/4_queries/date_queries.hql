use employee;

-- Employees born after Oct 1, 1955.
select * from employees where unix_timestamp(birth_date) < unix_timestamp('1952-02-15', 'yyyy-MM-dd');
