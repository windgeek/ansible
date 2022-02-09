#!/bin/bash
su - hbase <<EOF
hbase shell <<TTTT
create_namespace 'k19_media'

## 创建ntc_oss_small_file表（需要在Hadoop中配置HDFS的副本数为2）
create 'k19_media:ntc_oss_small_file',{NAME => 'sf', BLOOMFILTER => 'ROW', VERSIONS => '1', IN_MEMORY => 'false', KEEP_DELETED_CELLS => 'FALSE', DATA_BLOCK_ENCODING => 'NONE', TTL => '7776000', MIN_VERSIONS => '0', BLOCKCACHE => 'true', BLOCKSIZE => '65536', REPLICATION_SCOPE => '0', COMPRESSION=> 'snappy'},{NUMREGIONS => 600, SPLITALGO => 'HexStringSplit'}

## 创建bda_oss_small_file表
create 'k19_media:bda_oss_small_file', {NAME => 'sf', BLOOMFILTER => 'ROW', VERSIONS => '1', IN_MEMORY => 'false', KEEP_DELETED_CELLS => 'FALSE', DATA_BLOCK_ENCODING => 'NONE', COMPRESSION => 'NONE', MIN_VERSIONS => '0', BLOCKCACHE => 'true', BLOCKSIZE => '65536', REPLICATION_SCOPE => '0'}

grant 'root', 'RWXCA', '@k19_media'
grant 'k19', 'RWXCA', '@k19_media'
grant 'k19', 'RWXCA', 'k19_media:ntc_oss_small_file'
grant 'k19', 'RWXCA', 'k19_media:bda_oss_small_file'

quit
TTTT
EOF