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

function  elasticsearch_process(){
    # elasticsearch 数据节点和查询节点是否做判断进行分离?
    status=`netstat -tulnp |grep 9200 |wc -l` 
    if [ $status -eq 0 ]
    then
        su - elastic -c "sh /opt/elasticsearch/bin/elasticsearch  --daemonize --silent"
    fi
    #su - elastic -c "sh /opt/elasticsearch-query/bin/elasticsearch -Epath.conf=/opt/elasticsearch-query/config --daemonize --silent"
}

node_exporter
elasticsearch_process
zabbix_agent
 