#!/bin/sh
#author songtiany630@163.com
#set -x

#delete network device IP configuration
sudo ifconfig em1 0.0.0.0 up promisc

#add a bridge
sudo brctl addbr br0

#bind interface with the bridge
sudo brctl addif br0 em1

#set STP on
sudo brctl stp br0 on

#config bridge and start it
sudo ifconfig br0 172.16.9.151 netmask 255.255.255.0 up

#config route
sudo route add default gw 172.16.9.1

echo "test local network 10sec later........."
sleep 10s

#test local network
ping -c 3 www.baidu.com

