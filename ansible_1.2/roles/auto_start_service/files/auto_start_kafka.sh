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

function burrow_exporter(){
    status=`netstat -tulnp |grep 9254 |wc -l`
    if [ ${status} == 0 ]
    then
        nohup /opt/Burrow-master/burrow-exporter --burrow-addr="http://${ip_addr}:8000" --metrics-addr="0.0.0.0:9254" --interval="15" --api-version="3" &
    else    
        echo "burrow exporter is running"
    fi
}
    
function  kafka_process(){
    kafka=$(netstat -anp|grep 6667 | wc -l)
    if [ $kafka -eq 0 ]
    then
       su - kafka -c "nohup /usr/bin/sh /opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties > /dev/null 2>&1 &"
    fi
}
    
node_exporter    
burrow_exporter
kafka_process
zabbix_agent