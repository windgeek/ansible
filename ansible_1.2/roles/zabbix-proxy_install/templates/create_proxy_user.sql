create database If Not Exists zabbix_proxy character set utf8 collate utf8_bin;
GRANT ALL PRIVILEGES on zabbix_proxy.* to zabbix_proxy@localhost IDENTIFIED BY 'zabbix_proxy';
GRANT ALL PRIVILEGES on zabbix_proxy.* to zabbix_proxy@'%' IDENTIFIED BY 'zabbix_proxy';
GRANT ALL PRIVILEGES on zabbix_proxy.* to zabbix_proxy@'*'IDENTIFIED BY 'zabbix_proxy';
GRANT ALL PRIVILEGES on zabbix_proxy.* to zabbix_proxy@'{{hostvars[inventory_hostname].ansible_default_ipv4.address}}'IDENTIFIED BY 'zabbix_proxy';
FLUSH PRIVILEGES;
