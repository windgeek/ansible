#！/bin/bash
hostname=`hostname`
ceph-deploy purge $hostname
ceph-deploy purgedata $hostname
ceph-deploy forgetkeys
if 
        [ $? -eq 0 ];then
                echo "ceph is unload"
else
                echo "ceph unload is back"
fi
# osd 卸载命令 
# dmsetup status 查询所有ceph osd  或者vgscan + vgremove 加查询出来的id
# dmsetup remove_all 删除所有查询的内容 
#系统基础软件版本过高可以用下面命令降级，按照yum提供的版本进行降级。
#yum downgrade libgcc gcc  cpp gcc-c++  libstdc++ libstdc++-devel libgomp  zlib zlib-devel libselinux libselinux-devel libselinux-utils libselinux-python libsepol  libsepol-devel glibc glibc-headers  glibc-utils glibc-devel glibc-common -y 