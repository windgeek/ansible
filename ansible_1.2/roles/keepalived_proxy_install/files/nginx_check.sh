#!/bin/bash
A=`ps -C nginx --no-header | wc -l`
#如果发现nginx进程挂掉
if [ $A -eq 0 ];then
        #尝试重启
        /usr/sbin/service nginx restart
        sleep 2
        #如果重启失败
        if [ `ps -C nginx --no-header |wc -l` -eq 0 ];then
                #停掉keepalived，使虚拟IP切换
                /usr/sbin/service keepalived stop

        fi
fi
#最好执行一下脚本 如果出现语法错误 
#:set fileformat=unix 设置下文本格式