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

function  synonym_service(){
    status=`netstat -tulnp |grep 5018 |wc -l`
    if [ $status -eq 0 ]
    then
        cd /data1/synonym/synonym/service
        su k19 -lc "/usr/bin/sh /data1/synonym/synonym/service/start_http.sh"
    fi
}
 
node_exporter
synonym_service
zabbix_agent
