#!/usr/bin/env bash
jarName="content2es-1.5.jar"
hdfsDir="hdfs://192.168.162.95:8020/user/k19/content2es/lib/*.jar"

struct_content_application_name="SCO-K19-SPARK-STRUCT-CONTENT-Application"
struct_content_executor_memory="4G"
struct_content_num_executors=2
struct_content_executor_cores=1

fullName=$(readlink -f $0)
fullPath=$(dirname ${fullName})
cd $fullPath/../

pwdPath=`pwd`
echo ${pwdPath}

jar uvf ${jarName} conf/conf_message.yaml
jar uvf ${jarName} conf/common.yaml
spark-submit --class com.bfd.k19.application.Content2ESApplication \
    --master yarn \
    --name ${struct_content_application_name} \
    --deploy-mode cluster \
    --executor-memory ${struct_content_executor_memory} \
    --num-executors ${struct_content_num_executors} \
    --conf spark.streaming.kafka.maxRatePerPartition=2000 \
    --conf spark.streaming.backpressure.initialRate=1000 \
    --conf spark.streaming.backpressure.enabled=true \
    --conf spark.memory.fraction=0.2 \
    --conf spark.serializer=org.apache.spark.serializer.KryoSerializer \
    --conf spark.executor.cores=${struct_content_executor_cores} \
    --conf spark.yarn.jars=${hdfsDir} \
    --files ${pwdPath}/conf/log4j.properties \
    ${jarName} conf conf_message.yaml