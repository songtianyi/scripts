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
sudo yum -y install yum-fastestmirror
sudo yum -y update

#install some useful tools
sudo yum -y install dstat
sudo yum -y install vim
sudo yum -y install wget
sudo yum -y install abiword
sudo yum -y install dia
sudo yum -y install bridge-utils
sudo yum -y install tunctl
sudo yum -y install git
sudo yum -y install httpd
sudo yum -y install telnet
sudo yum -y install davfs2

#install chromium
#install adobe flash

#install gcc compiler
sudo yum -y install gcc gcc-c++


##################spice#########################

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
sudo modprobe tun
sudo modprobe vhost-net
sudo modprobe virtio_net
sudo modprobe virtio_blk

#load kvm module,always needed afther you restart your system
sudo modprobe kvm
sudo modprobe kvm_intel

#when you meet Failed to open /dev/dsp oss: No such file or Directory problem
sudo modprobe snd_pcm_oss

#install libvirt and virt tools
sudo yum -y install libvirt libvirt-devel
sudo yum -y install virt-top

################################################

