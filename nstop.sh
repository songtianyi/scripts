#!/bin/sh
#author songtianyi630@163.com
#set -x

#down the devices
sudo ifconfig em1 down
sudo ifconfig br0 down

#unbind network interface
sudo brctl delif br0 em1

#delete bridge
sudo brctl delbr br0

#start network interface,configuration file in /etc/sysconfig/network-scripts/ifcfg-
#sudo ifup p3p1

ifconfig em1 up

echo "test local network.........."
#test network
ping -c 3 www.baidu.com
