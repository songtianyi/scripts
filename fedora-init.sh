#!/bin/sh 
set -e
set -u

#author songtianyi630@163.com


#essential tools
sudo yum -y install vim wget make gcc gcc-c++ autoconf yum-fastestmirror
#install rpmfusion
su -c 'yum localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'   
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
#office
sudo yum -y groupinstall "Office/Productivity"
#some useful tools
sudo yum -y install httpd telnet davfs2 compress svn git strace ffpeg rdesktop cdrecord dos2unix
#needed for mounting exfat
sudo yum -y install scons fuse-devel
#network tools 
sudo yum -y install dstat bridge-utils tunctl lynx
###############aliedit############################
if [ -f "aliedit.tar.gz" ] ; then
	echo package exists
else 
	wget https://download.alipay.com/alipaysc/linux/aliedit/1.0.3.20/aliedit.tar.gz 
	tar -xf aliedit.tar.gz
fi
if [ `getconf LONG_BIT` -eq 64 ];then
	echo 64bit
	ln -sv /usr/lib64/libpng15.so.15.* /usr/lib64/libpng12.so.0
else
	echo 32bit
fi
su $LOGNAME "./aliedit.sh"
rm -rf aliedit*
####################git repo######################
##################################################

#update
sudo yum -y update

