#!/bin/sh
#set +x


######################essential tools#############

#network tools 
sudo yum -y install dstat
sudo yum -y install wget
sudo yum -y install bridge-utils
sudo yum -y install tunctl
#essential tools
sudo yum -y install vim
sudo yum -y install make
sudo yum -y install gcc gcc-c++




##################spice###########################

sudo yum -y install glib2-devel
sudo yum -y install zlib-devel
sudo yum -y install pixman-devel
sudo yum -y install autoconf
sudo yum -y install celt051-devel
#install sohu repo
sudo wget http://mirrors.sohu.com/fedora-epel/6/x86_64/epel-release-6-8.noarch.rpm
sudo yum -y install epel-release-6-8.noarch.rpm
sudo rm  -f epel-release-6-8.noarch.rpm
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




##############Download and extract files########

#usblib
USBLIB="libusb-1.0.9.tar.bz2"
if [ -f $USBLIB ]; then
	echo $USBLIB exists
else
	sudo wget http://sourceforge.net/projects/libusb/files/libusb-1.0/libusb-1.0.9/libusb-1.0.9.tar.bz2
fi
#usbredir
USBREDIR="usbredir-0.6.tar.bz2"
if [ -f $USBREDIR ]; then
	echo $USBREDIR exists
else
	sudo wget http://spice-space.org/download/usbredir/usbredir-0.6.tar.bz2
fi
#spice
SPICE="spice-0.12.3.tar.bz2"
SPICEPRO="spice-protocol-0.12.6.tar.bz2" 
if [ -f $SPICE ]; then
	echo $SPICE exists
else
	sudo wget http://spice-space.org/download/releases/spice-0.12.3.tar.bz2
fi
if [ -f $SPICEPRO ]; then
	echo $SPICEPRO exists 
else
	sudo wget http://spice-space.org/download/releases/spice-protocol-0.12.6.tar.bz2
fi
#qemu
QEMU="qemu-1.4.2.tar.bz2"
if [ -f $QEMU ]; then
	echo $QEMU exists
else
	sudo wget http://wiki.qemu-project.org/download/qemu-1.4.2.tar.bz2
fi
#extract
sudo tar -xf libusb-1.0.9.tar.bz2
sudo tar -xf usbredir-0.6.tar.bz2
sudo tar -xf spice-0.12.3.tar.bz2
sudo tar -xf spice-protocol-0.12.6.tar.bz2
sudo tar -xf qemu-1.4.2.tar.bz2




##################install#######################
sudo pwd
#install libusb
cd libusb-1.0.9
sudo pwd
sudo ./configure > /dev/null 
sudo make > /dev/null 
sudo make install > /dev/null 
cd .. 
sudo cp /usr/local/lib/pkgconfig/libusb-1.0.pc /usr/lib64/pkgconfig/
#install usbredir
cd usbredir-0.6
sudo pwd
sudo ./configure > /dev/null 
sudo make > /dev/null 
make install > /dev/null 
cd ..
#install spice protocol
cd spice-protocol-0.12.6
sudo pwd
sudo ./configure > /dev/null 
sudo make  > /dev/null 
make install > /dev/null 
cd ..
#install spice
cd spice-0.12.3
sudo pwd
sudo ./configure --enable-smartcard --enable-client --enable-opengl > /dev/null  
sudo make > /dev/null  
sudo make install > /dev/null  
cd ..
install qemu
sudo cp /usr/local/lib/pkgconfig/spice-server.pc /usr/lib64/pkgconfig/
sudo cp /usr/local/share/pkgconfig/spice-protocol.pc /usr/lib64/pkgconfig/
sudo cp /usr/local/lib/pkgconfig/libusbredir* /usr/lib64/pkgconfig/
cd qemu-1.4.2
sudo ./configure --enable-spice --enable-linux-aio --enable-virtio-blk-data-plane --enable-sdl --enable-usb-redir | grep yes
echo "making...."
sudo make > /dev/null
echo "installing...."
sudo make install > /dev/null
#add lib path
sudo sed '$a /usr/local/lib/' /etc/ld.so.conf
sudo ldconfig
echo 'everything is done! enjoy!'
