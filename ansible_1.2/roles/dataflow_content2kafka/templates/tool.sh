#!/usr/bin/env bash
#创建html topic
/opt/kafka/bin/kafka-topics.sh --create --zookeeper 172.18.9.51:2181 --replication-factor 2 --partitions 3 --topic NTC-OSS-ES-HTML
#创建eml topic
/opt/kafka/bin/kafka-topics.sh --create --zookeeper 172.18.9.51:2181 --replication-factor 2 --partitions 3 --topic NTC-OSS-ES-EML
#创建eml topic
/opt/kafka/bin/kafka-topics.sh --create --zookeeper 172.18.9.51:2181 --replication-factor 2 --partitions 3 --topic NTC-OSS-ES-MESSAGE

/opt/kafka/bin/kafka-topics.sh --delete --zookeeper 172.18.9.51:2181 --topic NTC-OSS-ES-EML
/opt/kafka/bin/kafka-topics.sh --delete --zookeeper 172.18.9.51:2181 --topic NTC-OSS-ES-HTML
/opt/kafka/bin/kafka-topics.sh --delete --zookeeper 172.18.9.51:2181 --topic NTC-OSS-ES-MESSAGE


#消费topic
bin/kafka-console-consumer.sh --bootstrap-server 172.18.9.51:6667,172.18.9.52:6667 --topic NTC-OSS-ES-HTML --from-beginning

bin/kafka-console-consumer.sh --bootstrap-server 172.18.9.51:6667,172.18.9.52:6667 --topic NTC-OSS-ES-EML --from-beginning

bin/kafka-console-consumer.sh --bootstrap-server 172.18.9.51:6667,172.18.9.52:6667 --topic NTC-OSS-ES-MESSAGE --from-beginning

bin/kafka-console-producer.sh --broker-list 172.18.9.51:6667,172.18.9.52:6667 --topic NTC-OSS-ES-HTML

bin/kafka-console-consumer.sh --bootstrap-server 172.24.9.48:6667,172.24.9.49:6667 --topic TEST-LP --from-beginning
