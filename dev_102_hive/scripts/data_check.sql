use dev_102_ext;

select * from movies limit 10;
select userid, movieid, rating, from_unixtime(ts) as timestamp from ratings limit 10;
select * from tags limit 10;
