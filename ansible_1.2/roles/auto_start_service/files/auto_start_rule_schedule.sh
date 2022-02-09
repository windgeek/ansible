#!/bin/bash

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

function  rule_service(){
    status=`ps -ef |grep rule-service | grep -v grep |wc -l`
    if [ $status -eq 0 ]
    then
        su k19 -lc "bash /data1/rule-service/bin/start.sh"
    fi
}
    
function  schedule_service(){
    status=`ps -ef |grep schedule-service | grep -v grep |wc -l`
    if [ $status -eq 0 ]
    then
        su k19 -lc "bash /data1/schedule-service/bin/start.sh"
    fi
}

node_exporter
rule_service
schedule_service
zabbix_agent