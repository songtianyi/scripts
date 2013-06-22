#!/bin/sh
#kernel version 2.6.38.6-26.rc1.fc15.x86_64
#author songtianyi630@163.com

#check kernel version
kernel=$(uname -r)
if [ $kernel = "2.6.38.6-26.rc1.fc15.x86_64" ];then
	echo "OK"
else
	echo "check your kernel version"
fi
exit 1

########################system##################

#update
sudo yum -y update

#install adobe flash

#install chromium

#install word processor
sudo yum -y install abiword

#network config tools
sudo yum -y install bridge-utils
sudo yum -y install tunctl


#install git tool
sudo yum -y install git

#install gcc compiler
sudo yum -y install gcc gcc-c++


#install VNC
sudo yum -y install vnc


###################KVM##########################
sudo modprobe kvm
sudo modprobe kvm_intel

###################qemu#########################

#when you meet Failed to open /dev/dsp oss: No such file or Directory problem
sudo modprobe snd_pcm_oss


##################spice#########################




