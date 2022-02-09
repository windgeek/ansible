#!/bin/bash

ip_addr=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d 'addr'`

# auto start ceph_exporter ceph_process ceph_osd_process
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

function  ceph_exporter(){
    status=`ps -ef |grep ceph_exporter |grep -v grep |wc -l`
    if [ ${status} == 0 ]
    then
        pm2 start /opt/ceph_exporter/bin/ceph_exporter
    fi
}
    
function  ceph_process(){
    hostname=`hostname`
    # 使用jq 工具获取mon 列表   注：每台服务器安装jq
    #cephmon_array=`ceph quorum_status -f json-pretty  | jq '. | {quorum_names:.quorum_names}' |sed '1,2d'| sed '$d' |sed '$d' | sed 's/,//g' | sed 's/"//g' |sed 's/^\s*//'`
    cephmon_array=`ceph mon stat |awk -F '{' '{print $2}' |awk -F '}' '{print $1}'  |sed 's/,/\n/g' | awk -F '=' '{print $1}'`
    rgw=`systemctl status ceph-radosgw@rgw.${hostname}.service |grep Active |awk '{print $2}'`
    # 判断mon 和mgr 是否在cephmon_array 中
    if [ ${rgw} != "active" ]
    then
        systemctl start ceph-radosgw@rgw.${hostname}.service
    fi

    for mon_hostname in ${cephmon_array[@]};do
        #echo $mon_hostname
        if [ ${hostname} == ${mon_hostname} ]
        then
            mon=`systemctl status ceph-mon@${hostname}.service  |grep Active |awk '{print $2}'`
            mgr=`systemctl status ceph-mgr@${hostname}.service |grep Active |awk '{print $2}'`
            if  [ ${mgr} != "active"  ]
            then
                systemctl start ceph-mgr@${hostname}.service
            fi 
            
            if [ ${mon} != "active" ] 
            then
                 systemctl start ceph-mon@${hostname}.service 
            fi
        fi
    done 
}

function ceph_osd_process() {
    # 获取ceph 集群所有osd 的编号 状态 ip. 
    # eg: 0 up 172.18.9.51
    ceph osd dump |grep osd. | sed '1,2d' |awk  '{print $1" "$2" "$16}' | awk -F 'osd.' '{print $2}' |awk -F ':' '{print $1}' | while read LINE
    do
        split=${LINE#* } 
	    status=${split% *}
        #echo "${status}"
        if [ $status == "down" ]
        then
            osd_ip=${split#* }
            #echo $osd_ip
	        if [ "${ip_addr}" == "${osd_ip}" ]
            then
                osd_id=${LINE%% *}
            #    echo $osd_id
                systemctl start ceph-osd@${osd_id}.service
            fi
        fi
    done
}
   
node_exporter
ceph_exporter
ceph_process
ceph_osd_process
zabbix_agent
