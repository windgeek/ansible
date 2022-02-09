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

function  zookeeper_process(){
    status=`netstat -tulnp |grep 2181 |wc -l`
    if [ $status -eg 0 ]
    then
        su - zookeeper -c "sh /opt/zookeeper/bin/zkServer.sh start"
    fi
}

function  zookeeper_exporter(){
    status=`netstat -tulnp |grep 9141 |wc -l`
    if [ $status -eg 0 ]
    then
        sh /data1/zookeeper_exporter/zookeeper_exporter
    fi
}
 
node_exporter
zookeeper_process
zookeeper_exporter
zabbix_agent
