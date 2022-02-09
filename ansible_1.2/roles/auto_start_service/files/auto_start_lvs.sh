#!/bin/bash

ip_addr=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d 'addr'`

# auto start kafka burrow_exporter
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

function  lvs_service(){
    status=`/usr/local/sbin/lvs_RIP.sh status | head -1 |awk '{print $6}'`
    if [ $status != "already" ]
    then
        /usr/local/sbin/lvs_RIP.sh start
    fi
}

node_exporter
lvs_service
zabbix_agent