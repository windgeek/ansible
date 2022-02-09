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

function  nginx_process(){
    status=`ps -ef |grep nginx |grep master |wc -l`
    if [ ${status} == 0 ]
    then
        /usr/sbin/nginx -c /etc/nginx/nginx.conf
    fi
}

node_exporter
nginx_process
zabbix_agent