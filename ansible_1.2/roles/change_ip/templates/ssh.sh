#!/bin/bash
yum  -y install expect
for i in `cat ip.txt` #ip.txt 文件写入需要免密的主机列表
do
password="k19sjk"
/usr/bin/expect -c "
spawn ssh-copy-id -i /root/.ssh/id_rsa.pub root@$i
expect {
\"*(yes/no)\" { send \"yes\r\";exp_continue }
\"*password\" { send \"$password\r\"; exp_continue }
}
expect eof"
done
