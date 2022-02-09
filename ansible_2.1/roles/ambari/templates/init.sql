create database if not exists ambari character set utf8;
grant all privileges on ambari.* to 'ambari'@'localhost' identified BY '{{ambari_mysql_password}}';
grant all privileges on ambari.* to 'ambari'@'%' identified BY '{{ambari_mysql_password}}';
grant all privileges on ambari.* to 'ambari'@'{{ansible_hostname}}' identified BY '{{ambari_mysql_password}}';
grant all privileges on ambari.* to 'ambari'@'{{hostvars[inventory_hostname].ansible_default_ipv4.address}}' identified BY '{{ambari_mysql_password}}';

create database if not exists hive character set utf8;
grant all privileges on hive.* to 'hive'@'localhost' identified BY '{{hive_mysql_password}}';
grant all privileges on hive.* to 'hive'@'%' identified BY '{{hive_mysql_password}}';
grant all privileges on hive.* to 'hive'@'{{ansible_hostname}}' identified BY '{{hive_mysql_password}}';
grant all privileges on hive.* to 'hive'@'{{hostvars[inventory_hostname].ansible_default_ipv4.address}}' identified BY '{{hive_mysql_password}}';
flush privileges;
