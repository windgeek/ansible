#!/bin/bash
#需要注意修改本脚本变量（osdmaster处盘数）以及ceph.conf ceph_rgw.conf中的配置以及 osdadd.sh中盘数变量

script_path={{dir}}
PORT={{ssh_port}}

#node_all="{{ groups.ceph_rgw_hosts[0] }} {{ groups.ceph_rgw_hosts[1] }} {{ groups.ceph_rgw_hosts[2] }}"
node_all="{% for host in groups.ceph_all %}{{ host }} {% endfor %}"
node_name=({% for host in groups.ceph_all %}{{ host }} {% endfor %})
#node_name=("{{ groups.ceph_rgw_hosts[0] }} {{ groups.ceph_rgw_hosts[1] }} {{ groups.ceph_rgw_hosts[2] }}")

function base(){
  cd $script_path/distribute-0.7.3
  python setup.py install
  easy_install distribute
  mkdir /etc/ceph
  cd /etc/ceph
  ceph-deploy new $node_all 
  ceph-deploy install --no-adjust-repos $node_all
  cd /etc/ceph
  for i in `seq 1 10`
  do
    ceph-deploy mon create-initial
    if [ $? -eq 0];then
       echo "mon is success"
       break;
    fi
  done
  cat $script_path/ceph.conf >> /etc/ceph/ceph.conf
  ceph-deploy --overwrite-conf admin $node_all
  chmod +r /etc/ceph/ceph.client.admin.keyring
  systemctl restart ceph-mon@{{ groups.ceph_rgw_hosts[0] }}
  systemctl restart ceph-mon@{{ groups.ceph_rgw_hosts[1] }}
  systemctl restart ceph-mon@{{ groups.ceph_rgw_hosts[2] }}
}

function osdnode(){
cd /etc/ceph
  ceph-deploy --overwrite-conf admin $node_all
  for i in ${node_name[*]}
    do
    	scp -o StrictHostKeyChecking=no $script_path/osdadd.sh $i:{{dir}}
    done
  for i in ${node_name[*]}
    do
      ssh -Tqp ${PORT} root@$i <<remotessh
    sh {{dir}}/osdadd.sh
remotessh
    done
}

function osdmaster(){
a=1
cd /etc/ceph
ceph-deploy --overwrite-conf admin $node_all
  for i in ${node_name[*]}
  do
    while [[ $a -lt {{number}} ]]                  #硬盘数量加1
    do
    j=`echo $a|awk '{printf "%c",97+$a}'` #系统盘是sda,如果是其它的需要修改脚本
    ceph-deploy osd create --data /dev/{{disk_lable}}${j} $i
    a=$(($a+1))
    done
    a=1
  done
}

function mgr(){
cd /etc/ceph
  ceph-deploy mgr create  $node_all
  systemctl enable ceph-mgr@{{ groups.ceph_rgw_hosts[0] }}
  systemctl start ceph-mgr@{{ groups.ceph_rgw_hosts[0] }}
  systemctl enable ceph-mgr@{{ groups.ceph_rgw_hosts[1] }}
  systemctl start ceph-mgr@{{ groups.ceph_rgw_hosts[1] }}
  systemctl enable ceph-mgr@{{ groups.ceph_rgw_hosts[2] }}
  systemctl start ceph-mgr@{{ groups.ceph_rgw_hosts[2] }}
  echo -e "\n[mgr]\nmgr modules = dashboard" >> /etc/ceph/ceph.conf
  ceph-deploy --overwrite-conf config push $node_all
  ceph mgr dump
  ceph mgr module enable dashboard
}

function rgw(){
cd /etc/ceph
  ceph-deploy install --no-adjust-repos --rgw $node_all
  cat $script_path/ceph_rgw.conf >> /etc/ceph/ceph.conf
  ceph-deploy --overwrite-conf config push $node_all
  ceph-deploy rgw create $node_all
  for i in ${node_name[*]}
  do
    ssh -Tqp ${PORT} root@$i <<remotessh
  systemctl restart ceph-radosgw@rgw.$HOSTNAME.service
remotessh
  done
}

function grant(){
cd /etc/ceph
  radosgw-admin user create --uid="admin" --display-name="admin"
  radosgw-admin caps add --uid=admin --caps="users=*"
  radosgw-admin caps add --uid=admin --caps="buckets=*"
  radosgw-admin caps add --uid=admin --caps="metadata=*"
  radosgw-admin caps add --uid=admin --caps="usage=*"
}

base
osdnode
osdmaster
mgr
rgw
grant