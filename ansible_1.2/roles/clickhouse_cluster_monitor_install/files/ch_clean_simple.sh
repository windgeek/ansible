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
for day_tb in k19_monitor.oss_monitor_log_local k19_monitor.k19_dm_log_monitor_local k19_monitor.oss_ratelimiter_log_local k19_monitor.table_oss_category_region_view_local k19_monitor.table_oss_serverIp_region_view_local k19_monitor.table_oss_fileName_view_local k19_monitor.data_streaming_exception_log k19_monitor.data_streaming_monitor_log k19_ods.mobile_cdr_log_local k19_ods.mobile_user_profile_log_local k19_ods.mobile_vlr_log_local k19_ods.mobile_http_log_local k19_ods.mobile_sms_log_local k19_ods.mobile_email_log_local k19_ods.ntc_ip_log_local_group_s_ip k19_ods.ntc_ip_log_local_group_d_ip k19_ods.ntc_ip_log_local_group_radius_account k19_ods.ntc_http_log_local_group_s_ip k19_ods.ntc_http_log_local_group_d_ip k19_ods.ntc_http_log_local_group_radius_account k19_ods.ntc_http_log_local_group_website k19_ods.dm_conv_log_local_group_client_ip k19_ods.dm_conv_log_local_group_server_ip k19_ods.ntc_mail_log_local_group_s_ip k19_ods.ntc_mail_log_local_group_d_ip k19_ods.ntc_mail_log_local_group_mail_from k19_ods.ntc_mail_log_local_group_mail_to
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

weektbs="k19_ods.ntc_account_log_local k19_ods.ntc_lbs_log_local k19_ods.ntc_mail_log_local k19_ods.ntc_radius_log_local k19_ods.ntc_voip_data_log_local k19_ods.ntc_voip_log_local k19_ods.ntc_im_log_local k19_ods.ntc_nat_log_local k19_ods.ntc_vpn_log_local"
echo "" > ${basepath}/drop_week_tables.txt
#删除按周分区表的过期分区(上面OPTIMIZE生效的话这里删除的会是空分区)
ftime2=`date -d "91 day ago" +"%Y-%m-%d %T"`
for week_tb in $weektbs
do
  echo "=`date`===========================删除以Week为分区的表${week_tb} =============================="
    if [ "x$week_tb" != "x" ]; then
        week_temp2=`date -d "${ftime2}" +"%s"`
        week_part2=`expr $week_temp2 / 3600 / 24 / 7`
    	echo "ALTER TABLE ${week_tb} DROP PARTITION ${week_part2};" >> ${basepath}/drop_week_tables.txt
        clickhouse-client --host=${host} --port=${port} --user=monitor --password=k19 --query="ALTER TABLE ${week_tb} DROP PARTITION ${week_part2};"
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
