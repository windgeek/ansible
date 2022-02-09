#!/bin/bash  

#查看所有磁盘状态
/opt/MegaRAID/MegaCli/MegaCli64 -PDList -aAll -Nolog | grep -i -E 'state|Slot\ Number'

#获取RAID适配器的信息（关键）
/opt/MegaRAID/MegaCli/MegaCli64 -AdpGetPciInfo -aAll  -Nolog
#这条命令主要要找到类似这个Adpater id: 0
#example
#Device Number   : 0
#这里看到适配器信息， Controller 0：适配器id为0，后面的命令中的 -a0 就是对应于这个参数
#
#获取硬盘背板信息（关键）
/opt/MegaRAID/MegaCli/MegaCli64 -EncInfo -a0  -Nolog
#example
# 这条命令主要是要找到类似这个 Enclosure Device ID: 32
## 即
## Device ID                     : 32  #Enclosure Device ID: 32
## Number of Physical Drives     : 14 # 服务器上现有的物理磁盘数


#查看当前各个虚拟磁盘中包含了哪些物理磁盘，数字代表（硬盘id）插槽编号
/opt/MegaRAID/MegaCli/MegaCli64 -LdPdInfo -a0  -Nolog | grep -E "Virtual Drive:|Slot Number:" | xargs | sed -r 's/(Slot Number:)(\s[0-9]+)/\2,/g' | sed 's/(Target Id: .)/Physical Drives ids:/g' | sed 's/Virtual Drive:/\nVirtual Drive:/g'
#example
#Virtual Drive: 0 Physical Drives ids:  12,  13,
#Virtual Drive: 1 Physical Drives ids:  0,  1,  2,  3,  4,  5,  6,  7,  8,  9,  10,


#导入foreign磁盘
#
#注意： 如果是raid卡导致的线上磁盘意外下线变成了foreign状态，则可以直接倒入。不要强制清除foreign状态，会丢失这个磁盘的所有数据。
#
#/opt/MegaRAID/MegaCli/MegaCli64 -CfgForeign -Import -a0 -Nolog
#清除Foreign状态
#
#注意： 有时候服务器上的磁盘会莫名其妙的变成foreign状态，此时不可以用下面的这个命令，因为这个命令会清理掉磁盘的文件系统和数据，要用import命令进行倒入。
#
#/opt/MegaRAID/MegaCli/MegaCli64 -CfgForeign -Clear -a0 -Nolog


