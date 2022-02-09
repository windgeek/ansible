#!/usr/bin/env bash
mysql  -uroot << EOF
set password = password("k18k18");
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'k18k18';
GRANT ALL PRIVILEGES ON *.* TO 'root'@localhost IDENTIFIED BY 'k18k18';
CREATE USER 'servent'@'%' IDENTIFIED BY 'k18k18';
GRANT ALL PRIVILEGES ON *.* TO 'servent'@'%' IDENTIFIED BY 'k18k18' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'servent'@'localhost' IDENTIFIED BY 'k18k18' WITH GRANT OPTION;
GRANT REPLICATION SLAVE,REPLICATION CLIENT ON *.* to 'servent'@'%' identified by 'k18k18';
GRANT REPLICATION SLAVE,REPLICATION CLIENT ON *.* to 'servent'@'localhost' identified by 'k18k18';
flush privileges;
EOF
