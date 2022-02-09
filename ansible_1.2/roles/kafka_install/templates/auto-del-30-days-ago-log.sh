#!/bin/sh
find {{ kafka.install_path }}/kafka/logs/ -mtime +30 -name "*.log*" -exec rm -rf {} \;
