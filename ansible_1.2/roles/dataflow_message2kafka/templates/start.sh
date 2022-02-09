#!/usr/bin/env bash

export JOB_NAME={{dataflow.region}}-K19-OSS-CONTENT-STRUCT-Application #yarn ui中的job名。可以根据该job名找到 applicationId
export parserJar=message2kafka-1.5-jar-with-dependencies.jar
export NUM_EXECUTORS={{ dataflow.message_num_executors }} # executors个数
export EXECUTORS_MEMORY=4G # 每个executor的内存大小
export EXECUTORS_CORES=1 # 每个executor的cpu核数
export CONFIG_HDFS_PATH=hdfs://{{ dataflow.namenode }}:8020/user/k19/message2kafka/json #引擎依赖的配置文件上传地址。
export JAR_HDFS_PATH=hdfs://{{ dataflow.namenode }}:8020/user/k19/message2kafka/lib/*.jar #依赖包的上传地址。

fullName=$(readlink -f $0)
fullPath=$(dirname ${fullName})
cd $fullPath/../

function join_by { local IFS="$1"; shift; echo "$*"; }

pwdPath=`pwd`
confFiles=$(ls ./json/*.json|xargs -I {} sh -c 'echo ${CONFIG_HDFS_PATH}/`basename {}`';)
confStr=$(join_by , ${confFiles} ${pwdPath}/conf/log4j.properties)

echo "Adding yaml files to ${parserJar}"
jar uvf ${parserJar}  conf/conf.yaml
jar uvf ${parserJar}  conf/common.yaml

echo "Loading jar ${parserJar}"
spark-submit --class com.bfd.k19.application.Message2KafkaApplication \
    --name ${JOB_NAME}\
    --master yarn \
    --deploy-mode cluster \
    --executor-memory ${EXECUTORS_MEMORY} \
    --num-executors ${NUM_EXECUTORS} \
    --files ${confStr} \
    --conf spark.streaming.kafka.maxRatePerPartition=20000 \
    --conf spark.streaming.backpressure.initialRate=10000 \
    --conf spark.streaming.backpressure.enabled=true \
    --conf spark.memory.fraction=0.2 \
    --conf spark.serializer=org.apache.spark.serializer.KryoSerializer \
    --conf spark.executor.cores=${EXECUTORS_CORES} \
    --conf spark.yarn.jars=${JAR_HDFS_PATH} \
    ${parserJar} conf conf.yaml