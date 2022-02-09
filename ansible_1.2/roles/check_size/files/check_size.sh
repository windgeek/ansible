#!/bin/bash
sum=`/opt/MegaRAID/MegaCli/MegaCli64 -PDList -aAll -Nolog | grep -i -E 'Slot\ Number|Raw Size'|grep -E -v '279|728'|grep -v "Slot\ Number"|wc -l`

if [[ $sum != 0 ]];then

/opt/MegaRAID/MegaCli/MegaCli64 -PDList -aAll -Nolog | grep -i -E 'Slot\ Number|Raw Size'|grep -E -v '279|728'|grep -B 1 "Raw\ Size"

fi
