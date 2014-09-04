#!/bin/bash

MEMLOG_1=$(free -k | egrep "\b${Mem}\b:")
MEM_TOTAL=$(echo $MEMLOG_1 | awk '{print $2}')

MEM_FREE=$(echo $MEMLOG_1 | awk '{print $4}')
MEM_BUFFERS=$(echo $MEMLOG_1 | awk '{print $6}')
MEM_CACHED=$(echo $MEMLOG_1 | awk '{print $7}')
MEM_FILE_ACTIVE=$(cat /proc/meminfo | grep "Active(file)" | awk '{print $2}')
MEM_CAN_USE=$(($MEM_FREE+$MEM_BUFFERS+$MEM_CACHED-$MEM_FILE_ACTIVE))

MEM_CAN_USE_RATE=`expr ${MEM_CAN_USE}/${MEM_TOTAL}*100 | bc -l`
MEM_USED_RATE=`expr 100-$MEM_CAN_USE_RATE | bc -l`
# Disp_SYS_Rate=`expr "scale=3; $MEM_RATE/1" |bc`
echo $MEM_USED_RATE
