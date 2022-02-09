#!/usr/bin/env bash

env="conf"
hdfsDir="hdfs://{{ dataflow.namenode }}:8020/user/k19/kafka2ck/lib"

fullName=$(readlink -f $0)
fullPath=$(dirname ${fullName})
cd $fullPath/../

pwdPath=`pwd`
jarName=$(ls -lt kafka2ck* | awk  '{print $9}' |head -n 1)

jar uvf ${jarName} ${env}/exception_monitor.yaml
jar uvf ${jarName} ${env}/common.yaml
spark-submit --class com.bfd.k19.application.DMError2CKApplication \
        --name TSE-K19-EXCEPTION-MONITOR-LOG-Application \
	--master yarn \
	--deploy-mode cluster \
	--executor-memory 4G \
	--num-executors 1 \
	--files ${pwdPath}/conf/log4j.properties \
	--conf spark.streaming.kafka.maxRatePerPartition=20000 \
	--conf spark.streaming.backpressure.initialRate=10000 \
	--conf spark.streaming.backpressure.enabled=true \
	--conf spark.memory.fraction=0.2 \
	--conf spark.serializer=org.apache.spark.serializer.KryoSerializer \
	--conf spark.executor.cores=1 \
	--conf spark.yarn.jars=${hdfsDir}/*.jar \
	${jarName} ${env} exception_monitor.yaml