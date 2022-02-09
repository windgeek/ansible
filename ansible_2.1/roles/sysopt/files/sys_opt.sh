#!/bin/bash

# #关闭开机自启动服务
# for i in `chkconfig --list |awk '{print $1}'`
# do
# chkconfig $i off;
# done

# #设置开机自启动服务
# for i in crond network haldaemon messagebus udev-post ntpd sshd rsyslog sysstat
# do
# chkconfig $i on;
# done

#关闭防火墙及ipv6，Centos7暂不关闭ipv6
#Centos6
#chkconfig iptables off
#chkconfig ip6tables off
#/etc/init.d/ip6tables stop
#/etc/init.d/iptables stop
#Centos7
systemctl stop firewalld.service
systemctl disable firewalld.service


#close seliunx
if [ `getenforce` != "Disabled" ];then
  setenforce 0
fi

#about ssh
#sed -i 's/#Port 22/Port 3222/' /etc/ssh/sshd_config
sed -i -e 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
#GSSAPIAuthentication 是否允许使用基于 GSSAPI 的用户认证.默认值为"no"

#modify max openfile and max process
cat > /etc/security/limits.conf << EOF
*           soft   nofile       655350
*           hard   nofile       655350
*           soft   nproc        655350
*           hard   nproc        655350
EOF

cat > /etc/security/limits.d/20-nproc.conf << EOF
*           soft   nproc        655350
*           hard   nproc        655350
root        soft   nproc     unlimited
EOF

#禁止键盘关闭命令
#sed -i 's#exec /sbin/shutdown -r now#\#exec /sbin/shutdown -r now#' /etc/init/control-alt-delete.conf

#优化内核参数
cat > /etc/sysctl.conf << EOF
#net.bridge.bridge-nf-call-ip6tables = 0
#net.bridge.bridge-nf-call-iptables = 0
#net.bridge.bridge-nf-call-arptables = 0
vm.swappiness = 1
net.ipv4.ip_forward = 0
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.default.accept_source_route = 0
kernel.sysrq = 0
kernel.core_uses_pid = 1
net.ipv4.tcp_syncookies = 1
kernel.msgmnb = 65536
kernel.msgmax = 65536
kernel.shmmax = 68719476736
kernel.shmall = 4294967296
net.ipv4.tcp_max_tw_buckets = 60000
net.ipv4.tcp_sack = 1
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_rmem = 4096 87380 4194304
net.ipv4.tcp_wmem = 4096 16384 4194304
net.core.wmem_default = 8388608
net.core.rmem_default = 8388608
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.core.netdev_max_backlog = 500000
net.core.somaxconn = 65535
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.tcp_max_syn_backlog = 262144
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_synack_retries = 1
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_mem = 94500000 915000000 927000000
net.ipv4.tcp_fin_timeout = 1
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.ip_local_port_range = 1024 65535
EOF
sysctl -p >/dev/null 2>&1


echo "unset MAILCHECK" >> /etc/profile
#echo "export TMOUT=0" >> /etc/profile
source /etc/profile

# /usr/sbin/ntpdate ntp.api.bz

# close swap
#swapoff -a

# close transparent_hugepage
echo never > /sys/kernel/mm/transparent_hugepage/defrag
echo never > /sys/kernel/mm/transparent_hugepage/enabled