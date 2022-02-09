#!/bin/bash
echo -n "" > /opt/Burrow-master/config/zk.txt
echo -n "servers= [" >> /opt/Burrow-master/config/zk.txt
for i in `cat /opt/Burrow-master/config/zk.yml`
do
        echo -n "\"$i\"," >> /opt/Burrow-master/config/zk.txt

done
echo "]" >> /opt/Burrow-master/config/zk.txt
sed -i 's/,]/]/g' /opt/Burrow-master/config/zk.txt
