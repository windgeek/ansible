#!/bin/bash
sum=`/opt/MegaRAID/MegaCli/MegaCli64 -PDList -aAll -Nolog | grep -i -E 'state|Slot\ Number' | grep -v "Online"| grep -B 1 -C 1 'Firmware\ state'|wc -l`

if [[ $sum != 0 ]];then

/opt/MegaRAID/MegaCli/MegaCli64 -PDList -aAll -Nolog | grep -i -E 'state|Slot\ Number' | grep -v "Online"| grep -B 1 -C 1 'Firmware\ state'

else
  echo "OK!"
fi
