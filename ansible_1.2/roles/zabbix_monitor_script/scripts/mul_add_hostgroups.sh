#!/bin/bash
base_dir=$(cd "$(dirname "$0")";pwd)
while read line
do
    python ${base_dir}/zabbix_api.py -A $line
done < ${base_dir}/hostgroup.txt
