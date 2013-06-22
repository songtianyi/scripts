#!/bin/sh
#set -x

#down the devices
sudo ifconfig p3p1 down
sudo ifconfig br0 down

#unbind network interface
sudo brctl delif br0 p3p1

#delete bridge
sudo brctl delbr br0

#start network interface,configuration file in /etc/sysconfig/network-scripts/ifcfg-
sudo ifup p3p1

echo "test local network.........."
#test network
ping -c 3 www.baidu.com
