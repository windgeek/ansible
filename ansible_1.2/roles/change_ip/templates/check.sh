#!/bin/bash
# real_ip.txt 为更改的真实ip
for i in `cat real_ip.txt`
do
        ping -c 3 -w 2 $i  &> /dev/null
        if [ $? -eq 0 ];then
                echo $i is alive >> alive_ip.txt
        else
                echo $i is dead  >> bead_ip.txt
        fi
done