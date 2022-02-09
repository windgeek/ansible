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

function network_service(){
    status=`ps -ef |grep network |grep -v grep |wc -l`
    if [ $status -lt 4 ]
    then
        access=`ps -ef |grep NetworkAccessService |grep -v grep |wc -l`
        euraka=`ps -ef |grep NetworkEurakaService |grep -v grep |wc -l`
        base=`ps -ef |grep NetworkBaseService |grep -v grep |wc -l`
        warn=`ps -ef |grep NetworkWarningService |grep -v grep |wc -l`
        
        if [ $access -eq 0 ]
        then   
            su k19 -lc "bash /data1/k19-network-service/NetworkAccessService/bin/start.sh"
        fi

        if [ $euraka -eq 0 ]
        then
            su k19 -lc "bash /data1/k19-network-service/NetworkEurakaService/bin/start.sh"
        fi

        if [ $base -eq 0  ]  
        then    
            su k19 -lc "bash /data1/k19-network-service/NetworkBaseService/bin/start.sh"   
        fi
        
        if [ $warn -eq 0 ]
        then
            su k19 -lc "bash /data1/k19-network-service/NetworkWarningService/bin/start.sh"
        fi
    fi

    xxl_job=`ps -ef |grep apache-tomcat-8.5.20 |grep -v grep |wc -l`
    if [ ${xxl_job} -eq 0  ]
    then
        su k19 -lc "bash /data1/k19-network-service/xxl-job/apache-tomcat-8.5.20/bin/startup.sh"
    fi
} 

node_exporter
network_service
zabbix_agent