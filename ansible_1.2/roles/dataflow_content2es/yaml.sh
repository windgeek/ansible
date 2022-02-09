#!/usr/bin/env bash
sed -i '' 's/172.24.9.56:6667,172.24.9.57:6667/{{kafkaBrokerList}}/g' templates/*.yaml
sed -i '' 's/172.24.9.48:6667,172.24.9.49:6667/{{monKafkaBrokerList}}/g' templates/*.yaml
sed -i '' 's/bjlg-3p208-lisong:8123,bjlg-3p209-lisong:8123/{{clickhouseIpPort}}/g' templates/*.yaml
sed -i '' 's/172.16.3.209:3306/{{geoIpMysql}}/g' templates/*.yaml
sed -i '' 's/k18k18/{{geoIpMysqlRootPasswd}}/g' templates/*.yaml
sed -i '' 's/tse/{{esClusterName}}/g' templates/*.yaml
sed -i '' 's/172.24.9.48,172.24.9.49,172.24.9.50/{{esNode}}/g' templates/*.yaml
sed -i '' 's/192.168.162.95:8899/{{cephEndPoint}}/g' templates/*.yaml
sed -i '' 's/9F8YOOSILYZ4ZBFXTHXE/{{cephAccessKeyId}}/g' templates/*.yaml
sed -i '' 's/skMSk9RF6gn0rMiocsQPxEDLG9kPhnx0mMyI8O6i/{{cephAccessKeySecret}}/g' templates/*.yaml
sed -i '' 's/192.168.162.95,192.168.162.96/{{hbaseZkNodes}}/g' templates/*.yaml
sed -i '' 's#http://k19-bigdata-2:8057/download_v2/#{{emlDownloadPath}}#g' templates/*.yaml


