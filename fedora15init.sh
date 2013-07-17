#!/bin/sh  -e 
#kernel version 2.6.38.6-26.rc1.fc15.x86_64
#author songtianyi630@163.com

#check kernel version
kernel=$(uname -r)

if [ $kernel = "2.6.38.6-26.rc1.fc15.x86_64" ];then
	echo "OK"
else
	read -n1 -p "The script is only tested in 2.6.38.6-26.rc1.fc15.x86_64,do you want to CONTINUE[Y/N]?" answer
	case "$answer" in
		Y|y) echo "OK";;
		*)	echo 
			echo "Terminated by user `whoami`"
			exit;;
	esac
fi




#essential tools
sudo yum -y install vim
sudo yum -y install wget
sudo yum -y install make
sudo yum -y install gcc gcc-c++
sudo yum -y install autoconf



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
sudo yum -y install git
sudo yum -y install svn
sudo yum -y install compress
sudo yum -y install strace
sudo yum -y install cscope
#install chromium
cd /etc/yum.repos.d/
sudo wget http://repos.fedorapeople.org/repos/spot/chromium/fedora-chromium-stable.repo
sudo yum -y install chromium
#install adobe flash
sudo yum install http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm -y
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
sudo yum install flash-plugin -y
#network tools 
sudo yum -y install dstat
sudo yum -y install bridge-utils
sudo yum -y install tunctl
sudo yum -y install lynx
    



###############################################
