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

function  redis_process(){
    status_7001=`netstat -tulnp |grep 7001 |wc -l`  
    status_7002=`netstat -tulnp |grep 7000 |wc -l`  
    if [ $status_7001 -eq 0  ]  
    then
        /data1/redis-5.0.2/src/redis-server /data1/redis-5.0.2/redis-cluster/7001/redis.conf
    fi

    if [ $status_7000 -eq 0  ]
    then   
        /data1/redis-5.0.2/src/redis-server /data1/redis-5.0.2/redis-cluster/7000/redis.conf
    fi
}

node_exporter
redis_process
zabbix_agent