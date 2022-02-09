#!/bin/bash
A=`ps -C nginx --no-header | wc -l`
if [ $A -eq 0 ];then

	/usr/sbin/service nginx restart
	
	sleep 2
	if [ `ps -C nginx --no-header |wc -l` -eq 0 ];then

		/usr/sbin/service keepalived stop
		#killall keepalived

	fi
fi
#最好执行一下脚本 如果出现语法错误 
#:set fileformat=unix 设置下文本格式
