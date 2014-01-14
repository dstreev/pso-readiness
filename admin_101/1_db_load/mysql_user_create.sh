create user 'vagrant'@'localhost' IDENTIFIED BY 'vagrant';
create user 'vagrant'@'%' IDENTIFIED BY 'vagrant';

grant all privileges on *.* to 'vagrant'@'localhost' with grant option;
grant all privileges on *.* to 'vagrant'@'%' with grant option;
