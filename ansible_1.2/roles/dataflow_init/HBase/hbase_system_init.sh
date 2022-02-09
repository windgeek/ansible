#!/bin/bash
su - hbase <<EOF
hbase shell <<TTTT
create_namespace 'k19_analy'

grant 'root', 'RWXCA', '@k19_analy'
grant 'k19', 'RWXCA', '@k19_analy'

quit
TTTT
EOF
