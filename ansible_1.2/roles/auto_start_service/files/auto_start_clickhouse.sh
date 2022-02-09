#!/bin/bash

ip_addr=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d 'addr'`

# auto start node-exporter clickhouse-exporter clickhouse pushgateway

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
 
function  clickhouse_process(){
    netstat=`netstat -tulnp |grep 8123 |wc -l`
    if [ ${netstat} == 0 ]
    then
        clickhouse-server --config-file=/etc/clickhouse-server/config.xml --daemon
    fi
}

function  clickhouse_exporter(){
    status=`systemctl status clickhouse_exporter |grep Active |awk '{print $2}'`
    if [ ${status} !=  "active" ]
    then
        systemctl start clickhouse_exporter
    fi
}

function  pushgateway(){
    status=`ps -ef |grep pushgateway |grep -v grep  |wc -l`
    if [ ${status} -eq  0 ]
    then
        nohup /opt/pushgateway/pushgateway & >> /dev/null 2>&1 &
    fi
}


node_exporter  
clickhouse_process
clickhouse_exporter
pushgateway
zabbix_agent

