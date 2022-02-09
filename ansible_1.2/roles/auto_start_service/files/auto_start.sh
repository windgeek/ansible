#!/bin/bash

ip_addr=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d 'addr'`

case $service in
    node-exporter )
    node_exporter
    ;;
    clickhouse-exporter )
    clickhouse_exporter
    ;;
    ceph-exporter )
    ceph_exporter
    ;;
    kafka-burrow )
    kafka_burrow
    ;;
    burrow-exporter )
    burrow_exporter
    ;;
    zookeeper-exporter )
    zookeeper_exporter
    ;;
    prometheus )
    prometheus_process
    ;;
    clickhouse )
    clickhouse_process
    ;;
    zookeeper )
    zookeeper_process 
    ;;
    oss-tomcat )
    tomcat_process
    ;;
    ceph )
    ceph_process
    ;;
    ceph_osd )
    ceph_osd_process
    ;;
    keepalived )
    keepalived_process
    ;;
    nginx )
    nginx_process
    ;;
    elasticsearch )
    elasticsearch_process
    ;;
    kafka )
    kafka_process 
    ;;
    redis )
    redis_process
    ;;
    mysql )
    mysql_process
    ;;
    postgresql )
    postgresql_process
    ;;
    neo4j )
    neo4j_process 
    ;;
    analysis-service )
    analysis_service
    ;;
    warn-service )
    warn_service
    ;;
    ontology-service )
    ontology_service
    ;;
    bi-service )
    bi_service
    ;;
    favorite-service )
    favorite_service
    ;;
    system-service )
    system_service
    ;;
    rule-service )
    rule_service
    ;;
    schedule-service )
    schedule_service
    ;;
    network-warning-service )
    network_warning_service
    ;;
    network-base-service )
    network_base_service
    ;;
    network-base-service )
    network_base_service
    ;;
    network-euraka-service )
    network_euraka_service
    ;;
    word_cloud )
    word_cloud
    ;;
    synonym-service )
    synonym_service
    ;;   
    xxl-job-admin )
    xxl_job_admin
    ;;
    xxl-job-import )
    xxl_job_import
    ;;
    xxl-job-merge )
    xxl-job-merge
    ;;  


function  node_exporter(){
    systemctl start node_exporter
  }
    
    
function  ceph_exporter(){
    pm2 start /opt/ceph_exporter/bin/ceph_exporter
}
    
function  kafka_burrow(){
    nohup /opt/Burrow-master/Burrow --config-dir /opt/Burrow-master/config &

}

function burrow_exporter(){
    nohup /opt/Burrow-master/burrow-exporter --burrow-addr="http://${ip_addr}:8000" --metrics-addr="0.0.0.0:9254" --interval="15" --api-version="3" &
}
    
function  zookeeper_exporter(){
    sh /data1/zookeeper_exporter/zookeeper_exporter
}
    
function  prometheus_process(){
    systemctl start prometheus
}
    
function  clickhouse_process(){
    clickhouse-server --config-file=/etc/clickhouse-server/config.xml --daemon
}
    
function  zookeeper_process(){
    su - zookeeper -c "sh /opt/zookeeper/bin/zkServer.sh start"
}
    
function  tomcat_process(){
    su - k19 -c "/bin/sh /opt/tomcat-oss/bin/startup.sh"
}
    
function  ceph_process(){
    hostname=`hostname`
    # 使用jq 工具获取mon 列表   注：每台服务器安装jq
    cephmon_array=`ceph quorum_status -f json-pretty  | jq '. | {quorum_names:.quorum_names}' |sed '1,2d'| sed '$d' |sed '$d' | sed 's/,//g' | sed 's/"//g' |sed 's/^\s*//'`
    rgw=`systemctl status ceph-radosgw@${hostname}.service |grep Active |awk '{print $2}'`
    # 判断mon 和mgr 是否在cephmon_array 中
    for mon_hostname in ${cephmon_array[@]};
    do
        if [ ${hostname} == ${mon_hostname} ]
        then
            mon=`systemctl status ceph-mon@${hostname}.service  |grep Active |awk '{print $2}'`
            mgr=`systemctl status ceph-mgr@${hostname}.service |grep Active |awk '{print $2}'`
            if  [ ${mgr} == "inactive" | ${mgr} == "failed" ]
            then
                systemctl start ceph-mgr@${hostname}.service 
            else if [ ${mon} == "inactive" | ${mon} == "failed" ] 
                 systemctl start ceph-mon@${hostname}.service 
            fi
        fi
    done 

    if [ ${rgw} == "inactive" | ${rgw} == "failed" ]
    then
        systemctl start ceph-radosgw@rgw.${hostname}.service
    fi
}

function ceph_osd_process() {
    # 获取ceph 集群所有osd 的编号 状态 ip. 
    # eg: 0 up 172.18.9.51
    ceph osd dump |grep osd. | sed '1,2d' |awk  '{print $1" "$2" "$16}' | awk -F 'osd.' '{print $2}' |awk -F ':' '{print $1}' | where read LINE
    do
        status=`$LINE |awk -F ' ' '{print $2}'`
        if [ $status != "up" ]
        then
            osd_ip=`$LINE | awk -F ' ' '{print $3}'`
            if [ $ip_addr == $osd_ip ]
            then
                osd_id=`$LINE | awk -F ' ' '{print $1}'`
                systemctl start ceph-osd@${osd_id}.service
            fi
        fi
    done
}
   
function  keepalived_process(){
    systemctl start keepalived   
}
    
function  nginx_process(){
    systemctl start nginx
}
    
function  elasticsearch_process(){
    # elasticsearch 数据节点和查询节点是否做判断进行分离?
    su - elastic -c "sh /opt/elasticsearch/bin/elasticsearch -Epath.conf=/opt/elasticsearch/config --daemonize --silent"
    su - elastic -c "sh /opt/elasticsearch-query/bin/elasticsearch -Epath.conf=/opt/elasticsearch-query/config --daemonize --silent"
}
    
function  kafka_process(){
    su - kafka -c "nohup /bin/sh /opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties > /dev/null 2>&1 &"
}
    
function  redis_process(){
    # 分端口进行判断
    /opt/redis-5.0.2/src/redis-server /opt/redis-5.0.2/redis-cluster/7001/redis.conf
    /opt/redis-5.0.2/src/redis-server /opt/redis-5.0.2/redis-cluster/7002/redis.conf
}
    
function  mysql_process(){
    systemctl restart mysqld
}
    
function  postgresql_process(){
    su - postgres -c "pg_ctl -D /data1/postgresql/data  -l /opt/postgresql/log/pg_server.log start"
}
    
function  neo4j_process(){
        su - neo4j -c "nohup /opt/neo4j/bin/neo4j start &>/dev/null &"
}
    
function  analysis_service(){
    su k19 -lc "bash /data1/analysis-service/bin/start.sh"
    su k19 -lc "bash /data1/analysis-service2/bin/start.sh"
}
    
function  warn_service(){
    su k19 -lc "bash /data1/warn-service/bin/start.sh"
    su k19 -lc "bash /data1/warn-service2/bin/start.sh"
}
    
function  ontology_service(){
    su k19 -lc "bash /data1/ontology-service/bin/start.sh"
    su k19 -lc "bash /data1/ontology-service2/bin/start.sh"
}
    
function  bi_service(){
    su k19 -lc "bash /data1/bi-service/bin/start.sh"
}
    
function  favorite_service(){
    su k19 -lc "bash /data1/favorite-service/bin/start.sh"
}
    
function  system_service(){
    su k19 -lc "bash /data1/system-service/bin/start.sh"
}
    
function  rule_service(){
    su k19 -lc "bash /data1/rule-service/bin/start.sh"
}
    
function  schedule_service(){
    su k19 -lc "bash /data1/schedule-service/bin/start.sh"
    su k19 -lc "bash /data1/schedule-service2/bin/start.sh"
}
    
function network_warning_service(){
    su k19 -lc "bash /data1/k19-network-service/NetworkWarningService/bin/start.sh"
}
    
function  network_base_service(){
    su k19 -lc "bash /data1/k19-network-service/NetworkBaseService/bin/start.sh"   
}
    
function  network_access_service(){
    su k19 -lc "bash /data1/k19-network-service/NetworkAccessService/bin/start.sh"
}

function  network_test_service(){
    su k19 -lc "bash /data1/k19-network-service/NetworkTestService/bin/start.sh"
} 
function  network_euraka_service(){
    su k19 -lc "bash /data1/k19-network-service/NetworkEurakaService/bin/start.sh"
    su k19 -lc "bash /data1/k19-network-service/NetworkEurakaService2/bin/start.sh"
}
    
function  word_cloud(){
    su k19 -lc "bash /data1/word_cloud/word_clouds/server/start_all.sh"    
}
    
function  synonym_service(){
    su k19 -lc "bash /data1/synonym/synonym/service/start_http.sh"
}
       
function  xxl_job_admin(){
    su k19 -lc "bash /data1/xxl-job-admin9097/bin/startup.sh"
}
    
function  xxl_job_import(){
    su k19 -lc "bash /data1/xxl-job-import9198/bin/startup.sh"
}

function  xxl-job-merge(){
    su k19 -lc "bash /data1/xxl-job-merge9099/binstartup.sh"
}
    
      