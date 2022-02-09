#!/bin/bash
#author: jianlong.zhang,sisi.wang
#time: 20200422
base_dir=$(cd "$(dirname "$0")";pwd)
source /etc/profile
source ~/.bash_profile
source ~/.bashrc
#1.获取IP地址
#ifconfig em1  |grep inet | sed -n '1p' | awk '{print "Address="$2}' | tee -a ${base_dir}/getcpumem.log  ${base_dir}/getother.log > /dev/null
Address=`/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print "Address="$2}' | head -1`
echo ${Address} | tee -a ${base_dir}/getcpumem.log  ${base_dir}/getother.log > /dev/null 
#2.获取内存使用率 usage/total
MemoryUsage=`free -m | awk 'NR==2{printf "MemoryUsage=%.2f\n",$3*100/$2 }'`
echo ${MemoryUsage} | tee -a  ${base_dir}/getcpumem.log ${base_dir}/getother.log > /dev/null


#3.获取Cpu使用率
 #依据/proc/stat文件获取并计算CPU使用率
 #CPU时间计算公式：CPU_TIME=user+system+nice+idle+iowait+irq+softirq
 #CPU使用率计算公式：cpu_usage=(idle2-idle1)/(cpu2-cpu1)*100
 #默认时间间隔
TIME_INTERVAL=5
LAST_CPU_INFO=$(cat /proc/stat | grep -w cpu | awk '{print $2,$3,$4,$5,$6,$7,$8}')
LAST_SYS_IDLE=$(echo $LAST_CPU_INFO | awk '{print $4}')
LAST_TOTAL_CPU_T=$(echo $LAST_CPU_INFO | awk '{print $1+$2+$3+$4+$5+$6+$7}')
sleep ${TIME_INTERVAL}
NEXT_CPU_INFO=$(cat /proc/stat | grep -w cpu | awk '{print $2,$3,$4,$5,$6,$7,$8}')
NEXT_SYS_IDLE=$(echo $NEXT_CPU_INFO | awk '{print $4}')
NEXT_TOTAL_CPU_T=$(echo $NEXT_CPU_INFO | awk '{print $1+$2+$3+$4+$5+$6+$7}')

 #系统空闲时间
SYSTEM_IDLE=`echo ${NEXT_SYS_IDLE} ${LAST_SYS_IDLE} | awk '{print $1-$2}'`
 #CPU总时间
TOTAL_TIME=`echo ${NEXT_TOTAL_CPU_T} ${LAST_TOTAL_CPU_T} | awk '{print $1-$2}'`
CPU_USAGE=`echo ${SYSTEM_IDLE} ${TOTAL_TIME} | awk '{printf "%.2f", 100-$1/$2*100}'`

echo "CpuUsage=${CPU_USAGE}" | tee -a ${base_dir}/getcpumem.log  ${base_dir}/getother.log > /dev/null 



#4.检测各个磁盘使用率. 0:磁盘空间已满 1:磁盘空间未满
value=`df -Th | awk '{print $6}' | awk -F'%' '{print $1}' | grep -v Use |sort -u |grep 100`
if [ ${value} -eq 100 ] ; then
        echo "DiskUsage=0" >> ${base_dir}/getother.log
else
        echo "DiskUsage=1" >> ${base_dir}/getother.log
fi

#5.检测raid 是否降级. 0:降级 1:正常
RaidStatus=`/opt/MegaRAID/MegaCli/MegaCli64 -LDInfo -Lall -aAll  -Nolog | grep -i -E 'Degraded' | awk -F': ' '{print $2}'`
if [ ${RaidStatus} == "Degraded" ]
then
	echo "RaidStatus=0" >> ${base_dir}/getother.log
else 
	echo "RaidStatus=1" >> ${base_dir}/getother.log
fi
#6.检测磁盘坏道情况. 0:磁盘坏道 1:磁盘正常
/opt/MegaRAID/MegaCli/MegaCli64 -PDList -aAll -Nolog | grep -i -E 'Slot Number:|Firmware state:|Media Error Count:|Other Error Count:|Predictive Failure Count:|Last Predictive Failure Event Seq Number:' | while read LINE
do

	Media_Error_Count=`echo $LINE | grep 'Media Error Count:' | awk -F: '{print $2}'`
	Other_Error_Count=`echo $LINE | grep 'Other Error Count:' | awk -F: '{print $2}'`
	Predictive_Failure_Count=`echo $LINE | grep 'Predictive Failure Count:' | awk -F: '{print $2}'`
	Last_Predictive_Failure_Event_Seq_Number=`echo $LINE | grep 'Last Predictive Failure Event Seq Number:' | awk -F: '{print $2}' `
	Firmware_state=`echo $LINE | grep -i -E 'Unconfigured|Rebuild|Failed|Offline|copyback|Missing|Offline' `
	



	if [ x"${Media_Error_Count}" != x ]
	then
		if [ $Media_Error_Count -gt 50 ]
		then
			echo "${LINE}" >> ${base_dir}/getdiskerror.log 
		fi
	elif [ x"${Other_Error_Count}" != x ]
	then
		if [ $Other_Error_Count -gt 50 ]
		then
			echo "${LINE}" >> ${base_dir}/getdiskerror.log
		fi
	elif [ x"${Predictive_Failure_Count}" != x ]
	then	
		if [ $Predictive_Failure_Count -gt 0 ]
		then	
			echo "${LINE}" >> ${base_dir}/getdiskerror.log
		fi
	elif [ x"${Last_Predictive_Failure_Event_Seq_Number}" != x ]
	then
		if [ $Last_Predictive_Failure_Event_Seq_Number -gt 0 ]
		then
			echo "${LINE}"  >> ${base_dir}/getdiskerror.log
		fi
	elif [ x"${Firmware_state}" != x ]
	then	
		echo "${LINE}" >> ${base_dir}/getdiskerror.log

	fi
	


done

if [ -s ${base_dir}/getdiskerror.log ]
then
       echo "DiskError=0" >> ${base_dir}/getother.log
else
       echo "DiskError=1" >> ${base_dir}/getother.log
fi
rm -rf ${base_dir}/getdiskerror.log

# 获取hostname
value=`hostname`
echo "Hostname=$value" >> ${base_dir}/getother.log
