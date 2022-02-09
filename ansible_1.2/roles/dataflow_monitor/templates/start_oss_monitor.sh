#!/usr/bin/env bash

env="conf"
hdfsDir="hdfs://{{ dataflow.namenode }}:8020/user/k19/kafka2ck/lib"

oss_monitor_application_name="TSE-K19-OSS-MONITOR-LOG-Application"
oss_monitor_executor_memory="4G"
oss_monitor_num_executors=1
oss_monitor_executor_cores=1

fullName=$(readlink -f $0)
fullPath=$(dirname ${fullName})
cd $fullPath/../

pwdPath=`pwd`
jarName=$(ls -lt kafka2ck* | awk  '{print $9}' |head -n 1)

jar uvf ${jarName} ${env}/oss_monitor.yaml
jar uvf ${jarName} ${env}/common.yaml
spark-submit --class com.bfd.k19.application.DmMonitor2CKApplication \
        --name ${oss_monitor_application_name} \
	--master yarn \
	--deploy-mode cluster \
	--executor-memory ${oss_monitor_executor_memory} \
	--num-executors ${oss_monitor_num_executors} \
	--files ${pwdPath}/conf/log4j.properties \
	--conf spark.streaming.kafka.maxRatePerPartition=20000 \
	--conf spark.streaming.backpressure.initialRate=10000 \
	--conf spark.streaming.backpressure.enabled=true \
	--conf spark.memory.fraction=0.2 \
	--conf spark.serializer=org.apache.spark.serializer.KryoSerializer \
	--conf spark.executor.cores=${oss_monitor_executor_cores} \
	--conf spark.yarn.jars=${hdfsDir}/*.jar \
	${jarName} ${env} oss_monitor.yaml