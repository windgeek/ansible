#!/usr/bin/env bash
sed -i '' 's/192.168.162.95:6667,192.168.162.96:6667/{{kafkaBrokerList}}/g' templates/*.yaml
sed -i '' 's/192.168.162.95:36667,192.168.162.95:46667/{{monKafkaBrokerList}}/g' templates/*.yaml
sed -i '' 's/172.16.3.209:3306/{{geoIpMysql}}/g' templates/*.yaml
sed -i '' 's/k18k18/{{geoIpMysqlRootPasswd}}/g' templates/*.yaml
sed -i '' 's/TSE/{{region}}/g' templates/*.yaml
sed -i '' 's/192.168.162.95:8899/{{cephEndPoint}}/g' templates/*.yaml
sed -i '' 's/9F8YOOSILYZ4ZBFXTHXE/{{cephAccessKeyId}}/g' templates/*.yaml
sed -i '' 's/skMSk9RF6gn0rMiocsQPxEDLG9kPhnx0mMyI8O6i/{{cephAccessKeySecret}}/g' templates/*.yaml
sed -i '' 's/192.168.162.95,192.168.162.96/{{hbaseZkNodes}}/g' templates/*.yaml


