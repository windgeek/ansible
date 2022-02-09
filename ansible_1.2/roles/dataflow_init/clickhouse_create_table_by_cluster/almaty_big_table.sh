#!/usr/bin/env bash
#The script is ys clickhouse initialization creation of national data center(TSE).The following parameter variables need to be modified before execution.

####################################
#定位当前目录
BATHPATH=$(cd `dirname $0`; pwd)
ck_init_script_path=${BATHPATH}/sql/almaty

source ${BATHPATH}/users
#单节点创建本地表脚本名
local_table_sql=ck_almaty_big_local.sql


#almaty local table hostname
#注意这是almaty httplog cluster的ip
almaty_local_host_name=(
10.3.45.134
10.3.45.135
)
#####################################

user=writer

tcp_port=9000

declare -A system_table_sqls=(
["system.trace_log"]="CREATE TABLE system.trace_log (event_date Date, event_time DateTime, revision UInt32, timer_type Enum8('Real' = 0, 'CPU' = 1), thread_number UInt32, query_id String, trace Array(UInt64)) ENGINE = MergeTree PARTITION BY toYYYYMM(event_date) ORDER BY (event_date, event_time) SETTINGS index_granularity = 1024"
["system.part_log"]="CREATE TABLE system.part_log (event_type Enum8('NewPart' = 1, 'MergeParts' = 2, 'DownloadPart' = 3, 'RemovePart' = 4, 'MutatePart' = 5, 'MovePart' = 6), event_date Date, event_time DateTime, duration_ms UInt64, database String, table String, part_name String, partition_id String, path_on_disk String, rows UInt64, size_in_bytes UInt64, merged_from Array(String), bytes_uncompressed UInt64, read_rows UInt64, read_bytes UInt64, error UInt16, exception String) ENGINE = MergeTree PARTITION BY toYYYYMM(event_date) ORDER BY (event_date, event_time) SETTINGS index_granularity = 8192;"
["system.query_log"]="CREATE TABLE system.query_log (type Enum8('QueryStart' = 1, 'QueryFinish' = 2, 'ExceptionBeforeStart' = 3, 'ExceptionWhileProcessing' = 4), event_date Date, event_time DateTime, query_start_time DateTime, query_duration_ms UInt64, read_rows UInt64, read_bytes UInt64, written_rows UInt64, written_bytes UInt64, result_rows UInt64, result_bytes UInt64, memory_usage UInt64, query String, exception String, stack_trace String, is_initial_query UInt8, user String, query_id String, address IPv6, port UInt16, initial_user String, initial_query_id String, initial_address IPv6, initial_port UInt16, interface UInt8, os_user String, client_hostname String, client_name String, client_revision UInt32, client_version_major UInt32, client_version_minor UInt32, client_version_patch UInt32, http_method UInt8, http_user_agent String, quota_key String, revision UInt32, thread_numbers Array(UInt32), os_thread_ids Array(UInt32), ProfileEvents.Names Array(String), ProfileEvents.Values Array(UInt64), Settings.Names Array(String), Settings.Values Array(String)) ENGINE = MergeTree PARTITION BY toYYYYMM(event_date) ORDER BY (event_date, event_time) SETTINGS index_granularity = 8192;"
)


#check system tables if exists,if not create it
function check_system_tables(){
  for ((i=0;i<${#almaty_local_host_name[*]};i++))
  do
    for table in system.trace_log system.part_log system.query_log
    do
       {
         msg=`clickhouse-client -m  -h ${almaty_local_host_name[i]} --port=${tcp_port}  --user=${user} --password=$writer -q "ATTACH TABLE $table;" 2>&1`
       }||{
            #如果不是表已经存在
            if [[ ${msg:0-17:16} != "already exists.." ]]
            then
               if [[  `clickhouse-client -m  -h ${almaty_local_host_name[i]} --port=${tcp_port}  --user=${user} --password=$writer  -q "EXISTS $table;"` == 0  ]]; then
            echo ${almaty_local_host_name[i]} $table doesn't exists' and now create it!
            clickhouse-client -m  -h ${almaty_local_host_name[i]} --port=${tcp_port}  --user=${user} --password=$writer  -q "${system_table_sqls[$table]}"
              fi
            fi
          }
    done
  done
}

check_system_tables


echo "almaty local table init ddl begin"
#create local table
function almaty_create_local_table(){
  for ((i=0;i<${#almaty_local_host_name[*]};i++))
  do
       echo "执行 ${ck_init_script_path}/${local_table_sql} 在 ${almaty_local_host_name[i]} 上创建本地表"
       cat ${ck_init_script_path}/${local_table_sql}|while read line
        do
          {
            #create或者alter命令
            if [[ ${line:0:6} = "CREATE" ||  ${line:0:5} = "ALTER" ]]
            then
                msg=`clickhouse-client --host=${almaty_local_host_name[i]} --port=${tcp_port} --user=${user} --password=$writer -q "$line"  2>&1`
            fi
          }||{
            #如果error是表已经存在则不显示
            if [[ ${msg:0-17:16} != "already exists.." ]]
            then
              echo "error:"$msg
            fi
          }
        done
  done
}

tables="k19_ods.ntc_ip_log_local k19_ods.ntc_http_log_local k19_ods.dm_conv_log_local k19_ods.ck_hour_increament_materialized_view_local k19_ods.ck_day_increament_materialized_view_local k19_ods.ck_slow_query_log_local k19_ods.ntc_ip_log_local_group_s_ip k19_ods.ntc_ip_log_local_group_d_ip k19_ods.ntc_ip_log_local_group_radius_account k19_ods.ntc_http_log_local_group_s_ip k19_ods.ntc_http_log_local_group_d_ip k19_ods.ntc_http_log_local_group_radius_account k19_ods.ntc_http_log_local_group_website k19_ods.dm_conv_log_local_group_client_ip k19_ods.dm_conv_log_local_group_server_ip"
function check(){
  for ((i=0;i<${#almaty_local_host_name[*]};i++))
  do
      echo "在${almaty_local_host_name[i]}执行本地表建表检查"
      for table in $tables
      do
        if [[  `clickhouse-client -m -d k19_ods -h ${almaty_local_host_name[i]} --port=${tcp_port}  --user=${user} --password=$writer  -q "EXISTS $table;"` == 0  ]]; then
            echo ${almaty_local_host_name[i]} $table doesn't exists'
        fi
      done
  done
}



#创建本地表
almaty_create_local_table
#检查建表情况
check