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

function  word_cloud(){
    status=`netstat -tulnp |grep 9018 |wc -l`
    if [ $status -eq 0 ]
    then 
        su k19 -lc "bash /data1/word_cloud/word_clouds/server/start_all.sh"    
    fi
}
 
node_exporter
word_cloud
zabbix_agent
