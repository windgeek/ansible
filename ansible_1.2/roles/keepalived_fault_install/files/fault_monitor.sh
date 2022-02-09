#!/bin/bash
A=`netstat -tulnp |grep -w 8384 |wc -l`
if [ $A -eq 0 ];then
        systemctl stop keepalived
fi
