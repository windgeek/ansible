#!/bin/bash

date="`date +%Y%m%d%H%M%S`"
echo $date
su - hbase <<EOF
hbase shell <<TTTT
snapshot 'k19_media:ntc_oss_small_file', 'ntc_oss_small_file_$date'
snapshot 'k19_media:bda_oss_small_file', 'bda_oss_small_file_$date'
quit
TTTT
EOF