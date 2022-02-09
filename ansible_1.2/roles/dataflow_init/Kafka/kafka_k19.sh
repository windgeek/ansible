#!/bin/bash

topics=(K19-NTC-IP-LOG K19-NTC-HTTP-LOG K19-NTC-MAIL-LOG K19-NTC-RADIUS-LOG K19-NTC-ACCOUNT-LOG K19-NTC-LBS-LOG K19-NTC-IM-LOG K19-NTC-VOIP-LOG K19-NTC-NAT-LOG K19-DM-CONV-LOG K19-LOGSTASH-MONITOR-LOG K19-OSS-MONITOR-LOG K19-OSS-CONTENT K19-SPARK-HTTP-CONTENT K19-SPARK-MAIL-CONTENT K19-SPARK-STRUCT-CONTENT K19-SPARK-EXCEPTION-LOG)
region=$3
case $region in
  Astana )
  arr=( 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 )
    ;;
  esac
length=${#arr[@]}
for ((i=0;i<=$length-1;i++))
do
  /opt/kafka/bin/kafka-topics.sh --create --zookeeper ${1} --replication-factor $2 --partitions ${arr[i]} --topic ${topics[$i]}
done
/opt/kafka/bin/kafka-topics.sh --list --zookeeper ${1}
