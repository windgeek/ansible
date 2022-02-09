#! /bin/bash

source /etc/profile
source ~/.bash_profile
source ~/.bashrc

#clickhouse按照partition清理数据
host=`hostname`
port=9000
#时间换算变量
a=3600
b=24
#clickhouse存放表的位置
datadir=/data1/clickhouse-server/data/data/k19_ods
basepath="$(cd `dirname $0`; pwd)"

#获取要删除前90天代表天数的日期
ftime=`date -d "90 day ago" +"%Y-%m-%d %T"`


echo "" > ${basepath}/drop_day_tables.txt
#删除按天分区表的过期分区
#for day_tb in $(cat ${basepath}/day_tables | grep -v '^#' | grep -v '^$' )
for day_tb in k19_ods.ntc_ip_log_local k19_ods.ntc_http_log_local k19_ods.dm_conv_log_local k19_ods.ntc_ip_log_local_group_s_ip k19_ods.ntc_ip_log_local_group_d_ip k19_ods.ntc_ip_log_local_group_radius_account k19_ods.ntc_http_log_local_group_s_ip k19_ods.ntc_http_log_local_group_d_ip k19_ods.ntc_http_log_local_group_radius_account k19_ods.ntc_http_log_local_group_website k19_ods.dm_conv_log_local_group_client_ip k19_ods.dm_conv_log_local_group_server_ip
do
  echo "=`date`===========================删除以Day为分区的表${day_tb} =============================="
    if [ "x$day_tb" != "x" ]; then
        day_temp=`date -d "${ftime}" +"%s"`
        day_part=`expr $day_temp / 3600 / 24`
    	echo "ALTER TABLE ${day_tb}  DROP PARTITION ${day_part};" >> ${basepath}/drop_day_tables.txt
        clickhouse-client --host=${host} --port=${port} --user=monitor --password=k19 --query="ALTER TABLE ${day_tb}  DROP PARTITION ${day_part};"
    fi
done

echo "---------------------------------------------------------------------------------------------------------------"
#目前没有按小时分区的表了
#echo hour_tempp=`date -d "${ftime}" +"%Y-%m-%d"`
#
## 清空临时文件
#echo " " > ${basepath}/hour_partition
## 将对应的4开头的时间节点写入到临时文件中
#for((i=0;i<24;i++));
#do
#  hour_temp=`date -d "${hour_tempp} ${i}:00:00" +"%s"`
#  hour_partition=`expr $hour_temp / 3600`
#  echo $hour_partition >> ${basepath}/hour_partition
#done
#
#echo " " > ${basepath}/drop_hour_tables.txt
#for hour_tb in k19_ods.ntc_ip_log_local zt.cdr_local zt.email_local zt.http_local zt.loc_local
#do
#  echo "=`date`========================删除以Hour为分区的表${hour_tb} =============================="
#    if [ "x$hour_tb" != "x" ]; then
#        for hour_pt in $(cat ${basepath}/hour_partition | grep -v '^#' | grep -v '^$' )
#        do
#          if [ "x$hour_pt" != "x" ]; then
#            echo "ALTER TABLE ${hour_tb}  DROP PARTITION ${hour_pt};" >> ${basepath}/drop_hour_tables.txt
#          fi
#        done
#    fi
#done
#
#clickhouse-client --host=${host} --port=${port} --user=monitor --password=k19 -n < ${basepath}/drop_hour_tables.txt
