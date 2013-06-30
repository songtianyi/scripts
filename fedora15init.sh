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




########################optional##################

#update
sudo yum -y update
#office
sudo yum -y install abiword
sudo yum -y install dia
#some useful tools
sudo yum -y install httpd
sudo yum -y install telnet
sudo yum -y install davfs2
sudo yum -y install emacs
sudo yum -y install git
sudo yum -y install svn
#install chromium
#install adobe flash
#install sohu repo
sudo wget http://mirrors.sohu.com/fedora-epel/6/x86_64/epel-release-6-8.noarch.rpm
sudo yum --enablerepo=epel -y install iksemel iksemel-devel
sudo rm -f epel-release-6-8.noarch.rpm




######################essential tools#############

#network tools 
sudo yum -y install dstat
sudo yum -y install wget
sudo yum -y install bridge-utils
sudo yum -y install tunctl
#essential tools
sudo yum -y install yum-fastestmirror
sudo yum -y install vim
sudo yum -y install make
sudo yum -y install gcc gcc-c++




##################spice###########################

sudo yum -y install glib2-devel
sudo yum -y install zlib-devel
sudo yum -y install pixman-devel
sudo yum -y install autoconf
sudo yum -y install celt051-devel
sudo yum -y install pyparsing
sudo yum -y install alsa-lib-devel
sudo yum -y install openssl-devel
sudo yum -y install libcacard libcacard-devel 
sudo yum -y install cairo-devel cairo
sudo yum -y install cyrus-sasl-devel
sudo yum -y install libjpeg-turbo-devel
#if you wanna enable gui,cegui is needed
#when you compile cegui, freetype2 and libpcre must be installed
sudo yum install -y freetype-devel
sudo yum install -y pcre-devel




###################qemu#########################

#install VNC
sudo yum -y install vnc
#install libaio-devel to enable linux-AIO
sudo yum -y install libaio-devel libaio
#install SDL-devel to enable SDL
sudo yum -y install SDL-devel




############for spice,kvm or qemu###############
#load some module,always needed afther you restart your system
sudo modprobe tun
sudo modprobe vhost-net
sudo modprobe virtio_net
sudo modprobe virtio_blk
sudo modprobe kvm
sudo modprobe kvm_intel
#when you meet Failed to open /dev/dsp oss: No such file or Directory problem
sudo modprobe snd_pcm_oss
#install libvirt and virt tools
sudo yum -y install libvirt libvirt-devel
sudo yum -y install virt-top

################################################

