create database If Not Exists  zabbix character set utf8 collate utf8_bin;
GRANT ALL PRIVILEGES on zabbix.* to zabbix@localhost IDENTIFIED BY 'zabbix';
GRANT ALL PRIVILEGES on zabbix.* to zabbix@'%' IDENTIFIED BY 'zabbix';
GRANT ALL PRIVILEGES on zabbix.* to zabbix@'*'IDENTIFIED BY 'zabbix';
GRANT ALL PRIVILEGES on zabbix.* to zabbix@'{{hostvars[inventory_hostname].ansible_default_ipv4.address}}'IDENTIFIED BY 'zabbix';
FLUSH PRIVILEGES;
