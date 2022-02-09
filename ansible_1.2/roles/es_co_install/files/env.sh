#!/usr/bin/env bash
ELASTIC='elastic'  #（*代表全部用户）
echo 'vm.max_map_count = 262144' >>/etc/sysctl.conf
sysctl -p
echo -ne "${ELASTIC}\t" >>/etc/security/limits.conf
echo -e  "hard  nproc    1048576" >>/etc/security/limits.conf
echo -ne "${ELASTIC}\t" >>/etc/security/limits.conf
echo -e  "soft  nproc    1048576" >>/etc/security/limits.conf
echo -ne "${ELASTIC}\t" >>/etc/security/limits.conf
echo -e  "hard  nofile   1048576" >>/etc/security/limits.conf
echo -ne "${ELASTIC}\t" >>/etc/security/limits.conf
echo -e  "soft  nofile   1048576" >>/etc/security/limits.conf

 #若要设置bootstrap.memory_lock: true 需要开启下面这行
echo -ne "${ELASTIC}\t" >>/etc/security/limits.conf
echo -e  "soft memlock unlimited" >>/etc/security/limits.conf
echo -ne "${ELASTIC}\t" >>/etc/security/limits.conf
echo -e  "hard memlock unlimited" >>/etc/security/limits.conf

#修改配置文件中的项目
#host_ip=`ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1 -d '/'`
#sed -i 's/network.host: '"ip"'/network.host: '"${host_ip}"'/g' /opt/elasticsearch/config/elasticsearch.yml
#host_name=`hostname`
#sed -i 's/node.name: '"host"'/node.name: '"${host_name}"'/g' /opt/elasticsearch/config/elasticsearch.yml