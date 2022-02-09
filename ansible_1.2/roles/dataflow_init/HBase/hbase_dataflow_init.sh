#!/bin/bash
su - hbase <<EOF
hbase shell <<TTTT

create 'default:cache',{NAME => 'cache', BLOOMFILTER => 'ROW', VERSIONS => '1', IN_MEMORY => 'false', KEEP_DELETED_CELLS => 'FALSE', DATA_BLOCK_ENCODING => 'FAST_DIFF', TTL => '604800', COMPRESSION => 'NONE', MIN_VERSIONS => '0', BLOCKCACHE => 'true', BLOCKSIZE => '65536', REPLICATION_SCOPE => '0'}

quit
TTTT
EOF


#表授权
su - hbase <<EOF
hbase shell <<TTTT
grant 'k19', 'RWXCA', '@default'
grant 'k19', 'RWXCA', 'default:cache'
quit
TTTT
EOF
