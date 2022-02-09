#!/usr/bin/env bash
source /etc/profile
mysql  -uroot << EOF
use mysql;
delete from user where user = '';
flush privileges;
EOF
