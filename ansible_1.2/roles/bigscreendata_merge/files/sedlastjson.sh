#!/bin/bash
base_dir=$(cd "$(dirname "$0")";pwd)
sed -i 's/\]\[/,/g'  ${base_dir}/mergecpumem.json
sed -i 's/\]\[/,/g'  ${base_dir}/mergeother.json
sed -i 's/\]//g'  ${base_dir}/mergelost.json
sed -i 's/\[//g'  ${base_dir}/mergelost.json
sed -i '/^$/d' ${base_dir}/mergelost.json
sed -i 's/}/},/g' ${base_dir}/mergelost.json
sed -i '$s/},/}/g' ${base_dir}/mergelost.json
sed -i '1i \[' ${base_dir}/mergelost.json 
sed -i '$a \]' ${base_dir}/mergelost.json
