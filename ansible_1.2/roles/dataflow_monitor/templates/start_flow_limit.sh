#!/usr/bin/env bash

env="conf"
hdfsDir="hdfs://{{ dataflow.namenode }}:8020/user/k19/kafka2ck/lib"

flow_limit_application_name="TSE-K19-FLOW-LIMIT-LOG-Application"
flow_limit_executor_memory="4G"
flow_limit_num_executors=1
flow_limit_executor_cores=1

fullName=$(readlink -f $0)
fullPath=$(dirname ${fullName})
cd $fullPath/../

pwdPath=`pwd`
jarName=$(ls -lt kafka2ck* | awk  '{print $9}' |head -n 1)

jar uvf ${jarName} ${env}/flow_limit.yaml
jar uvf ${jarName} ${env}/common.yaml
spark-submit --class com.bfd.k19.application.DmMonitor2CKApplication \
        --name ${flow_limit_application_name} \
	--master yarn \
	--deploy-mode cluster \
	--executor-memory ${flow_limit_executor_memory} \
	--num-executors ${flow_limit_num_executors} \
	--files ${pwdPath}/conf/log4j.properties \
	--conf spark.streaming.kafka.maxRatePerPartition=20000 \
	--conf spark.streaming.backpressure.initialRate=10000 \
	--conf spark.streaming.backpressure.enabled=true \
	--conf spark.memory.fraction=0.2 \
	--conf spark.serializer=org.apache.spark.serializer.KryoSerializer \
	--conf spark.executor.cores=${flow_limit_executor_cores} \
	--conf spark.yarn.jars=${hdfsDir}/*.jar \
	${jarName} ${env} flow_limit.yaml