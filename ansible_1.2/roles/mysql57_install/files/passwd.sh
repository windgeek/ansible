#!/bin/sh
str=`cat /opt/mysqldb/3306/log/error/mysql-error.log |grep 'temporary password'`
echo ${str##*:} > /usr/local/mysql/passwd
