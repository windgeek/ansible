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

function  ontology_service(){
    status=`ps -ef |grep ontology-service | grep -v grep |wc -l`
    if [ $status -eq 0 ]
    then
        su k19 -lc "bash /data1/ontology-service/bin/start.sh"
    fi
}
    
function  bi_service(){
    status=`ps -ef |grep bi-service | grep -v grep |wc -l`
    if [ $status -eq 0 ]
    then
        su k19 -lc "bash /data1/bi-service/bin/start.sh"
    fi 
}

node_exporter
ontology_service
bi_service
zabbix_agent