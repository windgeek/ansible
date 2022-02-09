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

function  analysis_service(){
    status=`ps -ef |grep analysis-service | grep -v grep |wc -l`
    if [ $status -eq 0 ]
    then
        su k19 -lc "bash /data1/analysis-service/bin/start.sh"
    fi 
}

function  warn_service(){
    status=`ps -ef |grep warn-service | grep -v grep |wc -l`
    if [ $status -eq 0 ]
    then
        su k19 -lc "bash /data1/warn-service/bin/start.sh"
    fi
}

node_exporter
analysis_service
warn_service
zabbix_agent