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

function  neo4j_process(){
    status=`/opt/neo4j/bin/neo4j status  | awk '{print $3}'`
    if [ $status == "not" ]
    then
        su - neo4j -c "nohup /opt/neo4j/bin/neo4j start &>/dev/null &"
    fi
}

node_exporter
neo4j_process
zabbix_agent