#!/usr/bin/env bash

# 1、对前1天的索引强制做forceMerge
# 2、删除第91天的索引数据

hostIp=$1
indexPrex=$2

#forceMerge前1天的数据
indexForceMergeDate=`date  +"%Y%m%d" -d  "-1 days"`
indexForceMergeName=`${indexPrex}_${indexForceMergeDate}*`
echo ${indexForceMergeName}
curl -XPOST "http://${hostIp}/${indexForceMergeName}/_forcemerge?only_expunge_deletes=false&max_num_segments=1&flush=true"

#删除90天以前的数据
indexDeleteDate=`date  +"%Y%m%d" -d  "-91 days"`
indexDeleteName=`${indexPrex}_${indexDeleteDate}*`
echo ${indexDeleteName}
curl -XDELETE "http://${hostIp}/${indexDeleteName}"