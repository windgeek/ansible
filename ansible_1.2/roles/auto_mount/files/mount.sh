#!/bin/bash  

i=1
while [ $i -lt 7 ]                  #硬盘数量,除系统盘之外是6块
do
j=`echo $i|awk '{printf "%c",97+$i}'` #系统盘是sda,如果是其它的需要修改脚本

mkfs.ext4 /dev/sd${j}  <<eof
y
eof

echo "OK"
mkdir /data${i}
mount="/dev/sd${j}       /data${i}  ext4    defaults        0       0"
rm -rf /data${i}/*
echo $mount >>/etc/fstab                #写入分区表 
i=$(($i+1))
done
echo "/n/n*****Formating  and Mounting have finished****/n/n"
mount -a      
