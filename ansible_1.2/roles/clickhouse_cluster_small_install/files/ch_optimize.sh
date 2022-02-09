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

ftime=`date -d "1 day ago" +"%Y-%m-%d %T"`

echo "---------------------------------------------------------------------------------------------------------------"


echo "" > ${basepath}/optimize_day_tables.log
#OPTIMIZE按天分区表的昨天的数据
for day_tb in k19_ods.dream_http_log_local k19_ods.dream_cdr_log_local k19_ods.dream_user_profile_log_local k19_ods.dream_vlr_log_local k19_ods.dream_sms_log_local k19_ods.dream_email_log_local   k19_ods.ntc_mail_log_local_group_s_ip k19_ods.ntc_mail_log_local_group_d_ip k19_ods.ntc_mail_log_local_group_mail_from k19_ods.ntc_mail_log_local_group_mail_to
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

weektbs="k19_ods.ntc_lbs_log_local k19_ods.ntc_mail_log_local k19_ods.ntc_radius_log_local k19_ods.ntc_voip_log_local k19_ods.ntc_nat_log_local k19_ods.ntc_vpn_log_local"
echo "" > ${basepath}/optimize_week_tables.log
#OPTIMIZE按周分区表
for week_tb in $weektbs
do
  echo "=`date`===========================OPTIMIZE以Week为分区的表${week_tb} =============================="
    if [ "x$week_tb" != "x" ]; then
        week_temp=`date -d "${ftime}" +"%s"`
        week_part=`expr $week_temp / 3600 / 24 / 7 `
    	echo "`date`===OPTIMIZE TABLE ${week_tb}  PARTITION ${week_part} FINAL;" >> ${basepath}/optimize_week_tables.log
        clickhouse-client --host=${host} --port=${port} --user=monitor --password=k19 --query="OPTIMIZE TABLE ${week_tb} PARTITION ${week_part};" &
    fi
done

echo "---------------------------------------------------------------------------------------------------------------"

