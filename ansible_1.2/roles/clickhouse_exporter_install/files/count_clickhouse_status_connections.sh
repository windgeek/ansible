#!/bin/bash
#ip_addr=`/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d 'addr'|head -n 1`

ip_addr=`hostname`
#这个函数需要在每台机器上执行
connection_status(){
	label="clickhouse_connections"  #定义key名
	connections=`netstat -anltup |grep clickhouse-s |wc -l`  #获取ck的连接数
	if [[ ${connections} == 0 ]]
	then
			status=1
	elif [[ ${connections} -gt 2000 ]]
	then
			status=1
	else
			status=0
	fi
	#SQL查询会因为进程没启动或者连接满了而失败
	#	cluster_name=`clickhouse-client -m -h $ip_addr -u writer --password k18 -q "select cluster from system.clusters where is_local limit 1;"  | awk '{print $1}'`
	cluster_name=`xmllint --xpath "//clickhouse_remote_servers/*[1]" /etc/clickhouse-server/metrika.xml |head -n 1`
	cluster_name=${cluster_name#*<}
	cluster_name=${cluster_name%%>}
	echo ${cluster_name}
	if [ -z $cluster_name ] #如果没有获取到集群名，比如进程挂了
	then
		echo 获取不到集群名
	fi

	echo $cluster_name,$ip_addr,$connections,$status
	echo "$label $connections" | curl --data-binary @- http://$ip_addr:9091/metrics/job/pushgateway/cluster_name/$cluster_name &
	echo "${label}_status $status" | curl --data-binary @- http://$ip_addr:9091/metrics/job/pushgateway/cluster_name/$cluster_name &

	connections=`netstat -anltup |grep clickhouse-s |grep CLOSE|wc -l`  #获取ck处于close_wait状态的连接数
	echo "${label}_close_wait $connections" | curl --data-binary @- http://$ip_addr:9091/metrics/job/pushgateway/cluster_name/$cluster_name &

}


connection_status
