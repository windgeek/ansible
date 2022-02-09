Kafka Install
=========

#### Kafka集群部署脚本

Requirements
------------

#### jdk
#### Zookeeper

Role Variables
--------------

#### 变量统一提取到group_vars/all文件中，变量说明：

```bash

kafka:
  log_path: kafka数据目录，需要一次写出用逗号隔开,e.g. /data1/kafka-logs,/data2/kafka-logs,/data3/kafka-logs,/data4/kafka-logs,/data5/kafka-logs,/data6/kafka-logs
  version: kafka部署包前缀,e.g. kafka_2.11-1.1.1
  zookeeper: kafka住的zk地址,e.g. 172.18.9.51:2181,172.18.9.52:2181,172.18.9.53:2181/kafka
  mk_logdirs: 手动创建的数据目录，e.g. /{data1,data2,data3,data4,data5,data6}/kafka-logs
  install_path: 部署目录，e.g. /opt
  user: 启动用户 kafka
  group: 启动用户组 kafka

```

Example Playbook
----------------

#### 包括两部分，install.yml 和 init.yml，分别是安装过程与初始化过程
#### 部署命令：
```bash 
ansible-playbook /etc/ansible/playbooks/kafka.yml
```