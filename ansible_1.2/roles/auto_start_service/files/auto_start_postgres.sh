#!/bin/bash

ip_addr=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d 'addr'`

function  node_exporter(){
    status=`systemctl status node_exporter |grep Active |awk '{print $2}'`
    if [ ${status} !=  "active" ]
    then
        systemctl start node_exporter
    fi
}

function  zabbix_agent(){
    status=`systemctl status zabbix-agent |grep Active |awk '{print $2}'`
    if [ ${status} !=  "active" ]
    then
        systemctl start zabbix-agent
    fi
}

function  postgresql_process(){
    status=`netstat -tulnp |grep 5432 |wc -l`
    if [ $status -eq 0 ]
    then
        su - postgres -c "pg_ctl -D /data1/postgresql/data  start"
    fi
}

node_exporter
postgresql_process
zabbix_agent

