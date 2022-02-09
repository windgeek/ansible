#!/usr/bin/env bash
mysql  -uroot << EOF
set password = password("baifendian");
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'baifendian';
GRANT ALL PRIVILEGES ON *.* TO 'root'@localhost IDENTIFIED BY 'baifendian';
CREATE USER 'si'@'%' IDENTIFIED BY 'baifendian';
GRANT ALL PRIVILEGES ON *.* TO 'si'@'%' IDENTIFIED BY 'baifendian' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'si'@'localhost' IDENTIFIED BY 'baifendian' WITH GRANT OPTION;
CREATE DATABASE si DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_unicode_ci;
GRANT ALL PRIVILEGES ON si.* TO 'si'@'%' IDENTIFIED BY 'baifendian';
GRANT ALL PRIVILEGES ON si.* TO 'si'@'localhost' IDENTIFIED BY 'baifendian';
flush privileges;
EOF

mysql -uroot -pbaifendian si < /tmp/public_opinion.sql
