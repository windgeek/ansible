#!/bin/bash
echo -n "" > /opt/Burrow-master/config/kafka.txt
echo -n "servers= [" >> /opt/Burrow-master/config/kafka.txt
for i in `cat /opt/Burrow-master/config/kafka.yml`
do
	echo -n "\"$i\"," >> /opt/Burrow-master/config/kafka.txt
	
done
echo "]" >> /opt/Burrow-master/config/kafka.txt
sed -i 's/,]/]/g' /opt/Burrow-master/config/kafka.txt 

