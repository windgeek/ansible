#!/bin/bash
ip_addr=`/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d 'addr'`
label="clickhouse_table_replicas_queue"  #定义key名
datalist=`clickhouse-client -h  $ip_addr -m  -q "
select concat('${label}',a.tables,' ',toString(a.queue_size)) as value from(
  select concat('{table=\"', database,'.',table,'\",name=\"queue_size\"}') as tables,sum(queue_size) as queue_size from k19_distribute.all_replicas group by tables union all


 select concat('{table=\"',database,'.',table,'\",name=\"inserts_in_queue\"}') as tables,sum(inserts_in_queue) as queue_size from k19_distribute.all_replicas group by tables

 union all

 select concat('{table=\"',database,'.',table,'\",name=\"merges_in_queue\"}') as tables,sum(merges_in_queue) as queue_size from k19_distribute.all_replicas group by tables) a "`
echo $datalist;


#for i in $datalist;
#  do
#   echo "$i"
#done
#curl -xpost --data-binary @ @- http://$ip_addr:9091/metrics/job/pushgateway/cluster_name/$cluster_name &
cat <<EOF | curl -XPUT -v --data-binary @- http://$ip_addr:9091/metrics/job/pushgateway/cluster_name/replicas_table
${datalist}
EOF
