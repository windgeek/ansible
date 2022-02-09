#!/bin/bash
function execute_getuntouch() {
   RES=`flock -x -n /data1/outoftouch1.log -c "echo ok"`
   if [ "$RES" = "ok" ];then
   	 yes |cp /data1/outoftouch1.log  /data1/outoftouch.log
   	/bin/bash /data1/mergedata/getuntouchinfo.sh
   else
        sleep 10s
        execute_getuntouch
   fi
}
execute_getuntouch
