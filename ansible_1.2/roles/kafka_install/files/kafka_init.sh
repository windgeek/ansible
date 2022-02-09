#!/bin/bash

topics=(K19-NTC-IP-LOG K19-NTC-HTTP-LOG K19-NTC-MAIL-LOG K19-NTC-RADIUS-LOG K19-NTC-ACCOUNT-LOG K19-NTC-LBS-LOG K19-NTC-IM-LOG K19-NTC-VOIP-LOG K19-NTC-NAT-LOG K19-DM-CONV-LOG K19-OSS-MONITOR-LOG K19-OSS-RATELIMITER-LOG K19-OSS-HTML-CONTENT K19-OSS-EML-CONTENT K19-SPARK-HTTP-CONTENT K19-SPARK-MAIL-CONTENT K19-SPARK-STRUCT-CONTENT K19-SPARK-EXCEPTION-LOG K19-DREAM-CDR-LOG K19-DREAM-PROFILE-LOG K19-DREAM-BASESTATION-LOG K19-DREAM-VLR-LOG K19-BIGSCREEN-ATTACK-CONV-LOG)
region=$3
case $region in
  Nursultan )
  arr=( 80 10 2 2 2 2 2 2 2 14 2 2 100 40 57 23 2 2 2 2 2 2 2 )
    ;;
  Aktau )
  arr=( 17 3 2 2 2 2 2 2 2 3 2 2 25 10 13 5 2 2 2 2 2 2 2 )
    ;;
  Aktubinsk )
  arr=( 49 7 2 2 2 2 2 2 2 9 2 2 80 20 35 14 2 2 2 2 2 2 2 )
    ;;
  Atyrau )
  arr=( 50 7 2 2 2 2 2 2 2 9 2 2 80 20 36 15 2 2 2 2 2 2 2 )
    ;;
  Karaganda )
  arr=( 49 7 2 2 2 2 2 2 2 9 2 2 80 20 35 14 2 2 2 2 2 2 2 )
    ;;
  Kokshetau )
  arr=( 37 5 2 2 2 2 2 2 2 7 2 2 60 20 26 11 2 2 2 2 2 2 2 )
    ;;
  Kostanay )
  arr=( 40 5 2 2 2 2 2 2 2 7 2 2 60 20 29 12 2 2 2 2 2 2 2 )
    ;;
  Kyzylorda )
  arr=( 17 3 2 2 2 2 2 2 2 3 2 2 25 10 13 5 2 2 2 2 2 2 2 )
    ;;
  Pavlodar )
  arr=( 80 10 2 2 2 2 2 2 2 14 2 2 100 40 57 23 2 2 2 2 2 2 2 )
    ;;
  Petropavl )
  arr=( 35 5 2 2 2 2 2 2 2 6 2 2 60 20 25 10 2 2 2 2 2 2 2 )
    ;;
  Semey )
  arr=( 16 2 2 2 2 2 2 2 2 3 2 2 20 10 12 5 2 2 2 2 2 2 2 )
    ;;
  Shymkent )
  arr=( 60 8 2 2 2 2 2 2 2 10 2 2 80 30 43 17 2 2 2 2 2 2 2 )
    ;;
  Taldykurgan )
  arr=( 23 3 2 2 2 2 2 2 2 4 2 2 30 10 17 7 2 2 2 2 2 2 2 )
    ;;
  Taraz )
  arr=( 19 3 2 2 2 2 2 2 2 4 2 2 25 10 13 6 2 2 2 2 2 2 2 )
    ;;
  Uralsk )
  arr=( 34 5 2 2 2 2 2 2 2 6 2 2 60 20 25 10 2 2 2 2 2 2 2 )
    ;;
  UstKamenogorsk )
  arr=( 38 5 2 2 2 2 2 2 2 7 2 2 60 22 28 11 2 2 2 2 2 2 2 )
    ;;
  Almaty )
  arr=( 117 15 2 2 2 2 2 2 2 20 2 2 150 50 84 34 2 2 2 2 2 2 2 )
    ;;
  Zhezkazgan )
  arr=( 2 2 2 2 2 2 2 2 2 3 2 2 4 3 2 2 2 2 2 2 2 2 2 )
    ;;
  esac
length=${#arr[@]}
for ((i=0;i<=$length-1;i++))
do
  /opt/kafka/bin/kafka-topics.sh --create --zookeeper ${1} --replication-factor $2 --partitions ${arr[i]} --topic ${topics[$i]}
done
/opt/kafka/bin/kafka-topics.sh --zookeeper ${1} --list