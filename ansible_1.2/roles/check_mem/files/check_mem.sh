#!/bin/bash

num=`free -h|grep 'Mem'|awk -F':' '{print $2}'|awk -F' ' '{print $1}'`

if [[ $num == '125G' ]];then
  echo "OK!"
else
  echo "Mem is $num"
fi
