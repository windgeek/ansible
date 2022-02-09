#!/usr/bin/env bash
#显示物理磁盘信息 通过这条命令来确认下面循环中的数字
#/opt/MegaRAID/MegaCli/MegaCli64 -PDList -aAll -Nolog
#清理foreign
/opt/MegaRAID/MegaCli/MegaCli64 -CfgForeign -Clear -a0 -Nolog
for i in {2..7}
do /opt/MegaRAID/MegaCli/MegaCli64 -CfgLdAdd -r0 [32:$i] -a0 -Nolog
done