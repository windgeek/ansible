#!/usr/bin/env bash
#The script is ys clickhouse initialization creation of national data center(TSE).The following parameter variables need to be modified before execution.



####################################
#定位当前目录
BATHPATH=$(cd `dirname $0`; pwd)
#调用sql的路径
ck_init_script_path=${BATHPATH}
source ${BATHPATH}/../../users
#创建分布式表脚本
drop_database_sql=ck_drop_database.sql


#clickhouse distribute cluster node hostname
drop_host_name=(
10.3.45.134
10.3.45.135
)
#####################################

user=writer

tcp_port=9000

for ((i=0;i<${#drop_host_name[*]};i++))
  do
      echo "在${drop_host_name[i]}执行 drop database"
      cat ${ck_init_script_path}/${drop_database_sql}|while read line
      do
        {
          msg=`clickhouse-client -m  -h ${drop_host_name[i]} --port=${tcp_port} --user=${user} --password=$writer -q "$line"  2>&1`
        }||{
          echo "error:"$msg
        }
      done
  done


