#!/bin/bash
#当i=1时，j=b；当i=0时，j=a。（避开系统盘所以 i=1）
i=1
#数据盘数量+1
while [ $i -lt 2 ]
do
#当i=1时，j=b；当i=0时，j=a。（避开系统盘所以 i=1）
j=`echo $i|awk '{printf "%c",97+$i}'`
#磁盘初始化
parted /dev/sd${j} mklabel gpt -s
#建立磁盘分卷
ceph-volume lvm zap /dev/sd${j}
i=$(($i+1))
done