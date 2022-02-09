#!/bin/bash
base_dir=$(cd "$(dirname "$0")";pwd)
address=`cat lost_result.json  |awk -F ':' '{print $4}' |awk -F '}' '{print $1}' | awk -F ' ' '{print $1}'`
if [ $address == "0" ]; then
    sed -i '1i \[' ${base_dir}/lost_result.json
    sed -i '$a \]' ${base_dir}/lost_result.json
else 
    sed -i 's/}{/},{/g'  ${base_dir}/lost_result.json
    sed -i 's/^/[/g' ${base_dir}/lost_result.json
    sed -i 's/$/]/g' ${base_dir}/lost_result.json 
fi
