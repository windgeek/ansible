#!/usr/bin/env bash
jarName="content2kafka-1.5.jar"
hdfsDir="hdfs://{{ dataflow.namenode }}:8020/user/k19/content2kafka/lib/*.jar"

num_executors={{ dataflow.eml_num_executors }}

fullName=$(readlink -f $0)
fullPath=$(dirname ${fullName})
cd $fullPath/../

pwdPath=`pwd`
echo ${pwdPath}

jar uvf ${jarName} conf/conf_eml.yaml
jar uvf ${jarName} conf/common.yaml
spark-submit --class com.bfd.k19.application.EmailContent2KafkaApplication \
    --master yarn \
    --name {{dataflow.region}}-K19-OSS-CONTENT-MAIL-Application \
    --deploy-mode cluster \
    --executor-memory 4G \
    --num-executors ${num_executors} \
    --conf spark.streaming.kafka.maxRatePerPartition=2000 \
    --conf spark.streaming.backpressure.initialRate=1000 \
    --conf spark.streaming.backpressure.enabled=true \
    --conf spark.memory.fraction=0.2 \
    --conf spark.serializer=org.apache.spark.serializer.KryoSerializer \
    --conf spark.executor.cores=1 \
    --conf spark.yarn.jars=${hdfsDir} \
    --files ${pwdPath}/conf/log4j.properties \
    ${jarName} conf conf_eml.yaml