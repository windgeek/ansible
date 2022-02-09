#!/usr/bin/env bash

su hdfs -c "hadoop fs -mkdir -p hdfs://{{ dataflow.namenode }}:8020/user/k19/message2kafka/json"
su hdfs -c "hadoop fs -mkdir -p hdfs://{{ dataflow.namenode }}:8020/user/k19/message2kafka/lib"
echo "结构化解析数据hdfs目录创建完成，开始上传文件"
su hdfs -c "hadoop fs -put {{ dataflow.install_path }}/{{ dataflow.message2kafka_name }}/lib/*.jar hdfs://{{ dataflow.namenode }}:8020/user/k19/message2kafka/lib/"
su hdfs -c "hadoop fs -put {{ dataflow.install_path }}/{{ dataflow.message2kafka_name }}/json/*.json hdfs://{{ dataflow.namenode }}:8020/user/k19/message2kafka/json/"
echo "结构化解析数据文件上传完成"
