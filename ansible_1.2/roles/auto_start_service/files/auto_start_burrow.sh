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

function  kafka_burrow(){
    status=`netstat -tulnp |grep 8000 |wc -l`
    if [ ${status} == 0 ]
    then
      nohup /opt/Burrow-master/Burrow --config-dir /opt/Burrow-master/config &
    fi
}

function burrow_exporter(){
    status=`netstat -tulnp |grep 9254 |wc -l`
    if [ ${status} == 0 ]
    then
        nohup /opt/Burrow-master/burrow-exporter --burrow-addr="http://${ip_addr}:8000" --metrics-addr="0.0.0.0:9254" --interval="15" --api-version="3" &
    else    
        echo "burrow exporter is running"
    fi
}

node_exporter
kafka_burrow
burrow_exporter
zabbix_agent