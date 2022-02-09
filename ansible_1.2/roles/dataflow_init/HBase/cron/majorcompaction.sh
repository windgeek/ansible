#!/bin/bash
#需要设置定时任务，哈萨克时间每周晚12点进行合并操作
su - hbase <<EOF
hbase shell <<TTTT
major_compaction 'k19_media.ntc_oss_small_file'
quit
TTTT
EOF