#!/bin/bash
status=`jps |grep YarnMonitorApp |wc -l`
if [ ${status} == 0 ]
then
  su - k18 -c "sh /home/k18/data-streaming-v1/monitor/yarn/start.sh" 
fi


#定时任务
#*/5 * * * * /bin/sh  /data1/sparkstreaming_monitor/start_sparkstreaming.sh