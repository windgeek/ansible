#!/bin/bash
#当i=1时，j=b；当i=0时，j=a。（避开系统盘所以 i=1）
i=1
#数据盘数量+1
while [[ $i -lt {{number}} ]]
do
#当i=1时，j=b；当i=0时，j=a。（避开系统盘所以 i=1） 下面代表从硬盘sdb开始创建osd  可以更改数字97来更改硬盘开始位置
j=`echo $i|awk '{printf "%c",97+$i}'`
#磁盘初始化
parted /dev/{{disk_lable}}${j} mklabel gpt -s
#建立磁盘分卷
ceph-volume lvm zap /dev/{{disk_lable}}${j}
i=$(($i+1))
done
