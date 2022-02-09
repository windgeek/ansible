#!/bin/bash
#########################################################################
#1、下面的ip.txt文件必须只有临时ip竖着排列，用来ssh连接.                    #                      
#2、下面的position.txt必须为现场真实SN号开头和机柜位置                     #
#3、ip_SN_position文件为最后生成临时ip+SN号+机柜位置                       #                         
#########################################################################
rm -f ip_SN
for i in `cat ip.txt`
do
        SN=`sshpass -p bfd123 ssh -p22 -q -o StrictHostKeyChecking=no root@$i "dmidecode -t system | grep 'Serial Number'"|awk  '{print $3}'`
        echo -e "$i\t$SN" >> ip_SN
done
rm -f ip_SN_position
while read ip_SN
do
        while read position
        do
                a=`echo $ip_SN|awk  '{print $2}'`
                b=`echo $position|awk '{print $1}'`
                        if [[ $a = $b ]];then
                                d=`echo $position|awk '{print $2}'`
                                echo -e "$ip_SN   $d">>ip_SN_position
                        fi
        done < position.txt
done < ip_SN
