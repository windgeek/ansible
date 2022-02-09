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

function  xxl_job_admin(){
    status=`ps -ef |grep xxl-job|grep -v grep |wc -l`
    if [ $status -lt 3 ]
    then
        admin=`ps -ef |grep xxl-job-admin9097|grep -v grep |wc -l`
        import=`ps -ef |grep xxl-job-import9198|grep -v grep |wc -l`
        merge=`ps -ef |grep xxl-job-merge9099|grep -v grep |wc -l`
        if [ $admin -eq 0 ]
        then
            su k19 -lc "bash /data1/xxl-job-admin9097/bin/startup.sh"
        fi

        if [ $import -eq 0 ]
        then
            su k19 -lc "bash /data1/xxl-job-import9198/bin/startup.sh"
        fi

        if [ $merge -eq 0 ]
        then
            su k19 -lc "bash /data1/xxl-job-merge9099/bin/startup.sh"
        fi
    fi
}
    
node_exporter
xxl_job_admin
zabbix_agent
    
      