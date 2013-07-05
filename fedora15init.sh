#!/bin/sh
#kernel version 2.6.38.6-26.rc1.fc15.x86_64
#author songtianyi630@163.com
#create date 2013-06-30
#update date 2013-07-01

#check kernel version
kernel=$(uname -r)
if [ $kernel = "2.6.38.6-26.rc1.fc15.x86_64" ];then
	echo "OK"
else
	echo "check your kernel version"
fi
exit 1




########################optional##################

#update
sudo yum -y update
#office
sudo yum -y install abiword
sudo yum -y install dia
#some useful tools
sudo yum -y install yum-fastestmirror
sudo yum -y install httpd
sudo yum -y install telnet
sudo yum -y install davfs2
sudo yum -y install emacs
sudo yum -y install git
sudo yum -y install svn
#install chromium
#install adobe flash
#network tools 
sudo yum -y install dstat
sudo yum -y install wget
sudo yum -y install bridge-utils
sudo yum -y install tunctl
#essential tools
sudo yum -y install vim
sudo yum -y install make
sudo yum -y install gcc gcc-c++
#install escope
if [ -f "cscope-15.8a.tar.gz" ]; then
    



###############################################

