#!/bin/sh
#set -x

#delete network device IP configuration
sudo ifconfig p3p1 0.0.0.0 up promisc

#add a bridge
sudo brctl addbr br0

#bind the interface to the bridge
sudo brctl addif br0 p3p1

#set STP on
sudo brctl stp br0 on

#config bridge and start it
sudo ifconfig br0 192.168.1.210 netmask 255.255.255.0 up

#config route
sudo route add default gw 192.168.1.1

echo "test local network........."
sleep 10s

#test local network
ping -c 3 www.baidu.com

