#!/bin/sh
#kernel version 2.6.38.6-26.rc1.fc1.x86_64
#author songtianyi630@163.com

#check kernel version
kernel=$(uname -r)
if [ $kernel = "2.6.43.8-1.fc15.x86_64" ];then
	echo "OK"
else
	echo "check your kernel version"
fi


###################network for qemu#########################

sudo yum -y install bridge-utils
sudo yum -y install tunctl


