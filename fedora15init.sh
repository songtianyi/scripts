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

#install rpmfusion
su -c 'yum localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'   
#update
sudo yum -y update
#office
sudo yum -y groupinstall "Office/Productivity"
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
sudo yum -y install ffmpeg
sudo yum -y install rdesktop
#needed for mounting exfat
sudo yum -y install scons
sudo yum -y install fuse-devel
#install chromium
cd /etc/yum.repos.d/
sudo wget http://repos.fedorapeople.org/repos/spot/chromium/fedora-chromium-stable.repo
sudo yum -y install chromium
sudo rm -f /etc/yum.repos.d/fedora-chromium-stable.repo
#install adobe flash
sudo yum install http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm -y
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
sudo yum install flash-plugin -y
sudo rm -f /etc/yum.repos.d/adobe-linux-x86_64.repo
#network tools 
sudo yum -y install dstat
sudo yum -y install bridge-utils
sudo yum -y install tunctl
sudo yum -y install lynx
#build spice-gtk
sudo yum -y install gtk-doc
sudo yum -y install libtool
sudo yum -y install perl-Text-CSV
sudo yum -y install pulseaudio-libs-devel
sudo yum -y install libgudev1-devel
sudo yum -y install libacl-devel


###############################################
