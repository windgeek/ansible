#!/usr/bin/env bash
#The script is ys clickhouse initialization creation of national data center(TSE).The following parameter variables need to be modified before execution.



####################################
#定位当前目录
BATHPATH=$(cd `dirname $0`; pwd)
ck_init_script_path=${BATHPATH}/sql/almaty
source ${BATHPATH}/users

#单节点创建本地表脚本名
local_table_sql=ck_almaty_drop_small_local.sql


#almaty local table hostname
almaty_local_host_name=(
10.3.45.134
10.3.45.135
)
#####################################

user=writer

tcp_port=9000



echo "almaty local table init drop begin"

#create local table
function almaty_drop_local_table(){
  for ((i=0;i<${#almaty_local_host_name[*]};i++))
  do
       echo "执行 ${ck_init_script_path}/${local_table_sql} 在 ${almaty_local_host_name[i]} 上创建本地表"
       cat ${ck_init_script_path}/${local_table_sql}|while read line
        do
          {
            #drop或者alter命令
            if [[ ${line:0:4} = "drop" ||  ${line:0:5} = "ALTER" ]]
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

tables="k19_ods.ntc_mail_log_local_group_s_ip k19_ods.ntc_mail_log_local_group_d_ip k19_ods.ntc_mail_log_local_group_mail_from k19_ods.ntc_mail_log_local_group_mail_to"
function check(){
  for ((i=0;i<${#almaty_local_host_name[*]};i++))
  do
      echo "在${almaty_local_host_name[i]}执行本地表建表检查"
      for table in $tables
      do
        if [[  `clickhouse-client -m -d k19_ods -h ${almaty_local_host_name[i]} --port=${tcp_port}  --user=${user} --password=$writer  -q "EXISTS $table;"` == 0  ]]; then
            echo ${almaty_local_host_name[i]} $table 删除成功
        fi
      done
  done
}




#创建本地表
almaty_drop_local_table
#检查建表情况
check


