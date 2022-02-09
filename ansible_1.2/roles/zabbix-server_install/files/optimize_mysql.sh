#!/usr/bin/env bash
mysql  -uroot -pk19k19  zabbix << EOF
truncate table history;
optimize table history;
truncate table history_str;
optimize table history_str;
truncate table history_uint;
optimize table history_uint;
truncate table trends;
optimize table trends;
truncate table trends_uint;
optimize table trends_uint;
EOF
