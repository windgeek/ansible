#!/usr/bin/env bash
#mysql --connect-expired-password -uroot -p$(sed -n '2p' /root/.mysql_secret) << EOF
mysql -uroot -p$(cat /usr/local/mysql/passwd) --connect-expired-password << EOF
set password = password("baifendian");
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'baifendian';
GRANT ALL PRIVILEGES ON *.* TO 'root'@localhost IDENTIFIED BY 'baifendian';
CREATE USER 'repl'@'%' IDENTIFIED BY 'baifendian';
GRANT ALL PRIVILEGES ON *.* TO 'repl'@'%' IDENTIFIED BY 'baifendian' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'repl'@'localhost' IDENTIFIED BY 'baifendian' WITH GRANT OPTION;
GRANT REPLICATION SLAVE,REPLICATION CLIENT ON *.* to 'repl'@'%' identified by 'baifendian';
GRANT REPLICATION SLAVE,REPLICATION CLIENT ON *.* to 'repl'@'localhost' identified by 'baifendian';
CREATE USER 'si'@'%' IDENTIFIED BY 'baifendian';
GRANT ALL PRIVILEGES ON *.* TO 'si'@'%' IDENTIFIED BY 'baifendian' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'si'@'localhost' IDENTIFIED BY 'baifendian' WITH GRANT OPTION;
CREATE DATABASE public_opinion DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_unicode_ci;
CREATE DATABASE system_manager DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_unicode_ci;
flush privileges;
EOF

#mysql -uroot -pbaifendian si < /tmp/public_opinion.sql
