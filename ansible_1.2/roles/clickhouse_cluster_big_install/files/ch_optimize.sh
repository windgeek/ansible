#! /bin/bash

source /etc/profile
source ~/.bash_profile
source ~/.bashrc

#clickhouse按照partition清理数据
host=`hostname`
port=9000

#clickhouse存放表的位置
datadir=/data1/clickhouse-server/data/data/k19_ods
basepath="$(cd `dirname $0`; pwd)"

#获取要OPTIMIZE的昨天数据的日期
ftime=`date -d "1 day ago" +"%Y-%m-%d %T"`

echo "---------------------------------------------------------------------------------------------------------------"

echo "" > ${basepath}/optimize_day_tables.log
#OPTIMIZE按天分区表的昨天的数据
for day_tb in k19_ods.ntc_ip_log_local k19_ods.ntc_http_log_local k19_ods.dm_conv_log_local  k19_ods.ntc_ip_log_local_group_s_ip k19_ods.ntc_ip_log_local_group_d_ip k19_ods.ntc_ip_log_local_group_radius_account k19_ods.ntc_http_log_local_group_s_ip k19_ods.ntc_http_log_local_group_d_ip k19_ods.ntc_http_log_local_group_radius_account k19_ods.ntc_http_log_local_group_website k19_ods.dm_conv_log_local_group_client_ip k19_ods.dm_conv_log_local_group_server_ip
do
  echo "=`date`===========================OPTIMIZE以Day为分区的表${day_tb} =============================="
    if [ "x$day_tb" != "x" ]; then
        day_temp=`date -d "${ftime}" +"%s"`
        day_part=`expr $day_temp / 3600 / 24`
    	echo "`date`===OPTIMIZE TABLE ${day_tb}  PARTITION ${day_part};" >> ${basepath}/optimize_day_tables.log
        clickhouse-client --host=${host} --port=${port} --user=monitor --password=k19 --query="OPTIMIZE TABLE ${day_tb} PARTITION ${day_part};" &
    fi
done

echo "---------------------------------------------------------------------------------------------------------------"

#weektbs="k19_ods.ntc_account_log_local k19_ods.ntc_lbs_log_local k19_ods.ntc_mail_log_local k19_ods.ntc_radius_log_local k19_ods.ntc_voip_data_log_local k19_ods.ntc_voip_log_local k19_ods.ntc_im_log_local k19_ods.ntc_nat_log_local k19_ods.ntc_vpn_log_local"
#echo "" > ${basepath}/optimize_week_tables.log
##OPTIMIZE按周分区表
#for week_tb in $weektbs
#do
#  echo "=`date`===========================OPTIMIZE以Week为分区的表${week_tb} =============================="
#    if [ "x$week_tb" != "x" ]; then
#        week_temp=`date -d "${ftime}" +"%s"`
#        week_part=`expr $week_temp / 3600 / 24 / 7 `
#    	echo "`date`===OPTIMIZE TABLE ${week_tb}  PARTITION ${week_part} FINAL;" >> ${basepath}/optimize_week_tables.log
#        clickhouse-client --host=${host} --port=${port} --user=monitor --password=k19 --query="OPTIMIZE TABLE ${week_tb} PARTITION ${week_part};" &
#    fi
#done
#
#echo "---------------------------------------------------------------------------------------------------------------"

#
#hour_tempp=`date -d "${ftime}" +"%Y-%m-%d"`
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
#echo "" > ${basepath}/optimize_hour_tables.log
##OPTIMIZE按小时分区表的昨天的数据
#for hour_tb in k19_ods.ntc_ip_log_local
#do
#  echo "=`date`========================OPTIMIZE以Hour为分区的表${hour_tb} =============================="
#    if [ "x$hour_tb" != "x" ]; then
#        for hour_pt in $(cat ${basepath}/hour_partition | grep -v '^#' | grep -v '^$' )
#        do
#          if [ "x$hour_pt" != "x" ]; then
#            echo "`date`===OPTIMIZE TABLE ${hour_tb}  PARTITION ${hour_pt};" >> ${basepath}/optimize_hour_tables.log
#			clickhouse-client --host=${host} --port=${port} --user=monitor --password=k19 --query="OPTIMIZE TABLE ${hour_tb} PARTITION ${hour_pt};" &
#          fi
#        done
#    fi
#done