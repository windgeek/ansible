#!/bin/bash
base_dir=$(cd "$(dirname "$0")";pwd)
cat ${base_dir}/getcpumem.log |while read line
do
	key=${line%=*}
	value=${line#*=}

	if [ $key == "Region" ]
	then
		echo -e '\t{' >> ${base_dir}/getcpumem01.log
	fi

	if [ $key == "CpuUsage" ]
	then
		echo -e '\t'\"${key}\": \"${value}\" >> ${base_dir}/getcpumem01.log
		echo -e '\t}' >> ${base_dir}/getcpumem01.log
	else
		echo -e '\t'\"${key}\": \"${value}\"\, >> ${base_dir}/getcpumem01.log
	fi
done 


cat ${base_dir}/getother.log |while read line
do
        key=${line%=*}
        value=${line#*=}

        if [ $key == "Region" ]
        then
                echo -e '\t{' >> ${base_dir}/getother01.log
        fi

        if [ $key == "FanStatus" ]
        then
                echo -e '\t'\"${key}\": \"${value}\" >> ${base_dir}/getother01.log
                echo -e '\t}' >> ${base_dir}/getother01.log
        else
                echo -e '\t'\"${key}\": \"${value}\"\, >> ${base_dir}/getother01.log
        fi
done

