#!/bin/sh
#author songtianyi630@163.com
#set +x


######################essential tools#############

#network tools 
sudo yum -y install wget
#essential tools
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
sudo yum -y install freetype-devel
sudo yum -y install pcre-devel




###################qemu#########################

#install VNC
sudo yum -y install vnc
#install libaio-devel to enable linux-AIO
sudo yum -y install libaio-devel libaio
#install SDL-devel to enable SDL
sudo yum -y install SDL-devel




#load modules
sudo sh load-kvm-spice-qemu-modules.sh

#############Download and extract files########

#specify usblib,usbredir,spice.spice-protocol,qemu package name
SBLIB="libusb-1.0.9.tar.bz2"
SBREDIR="usbredir-0.6.tar.bz2"
PICE="spice-0.12.3.tar.bz2"
PICEPRO="spice-protocol-0.12.6.tar.bz2"
EMU="qemu-1.4.2.tar.bz2"
#specify package url path
SBLIBPATH="http://sourceforge.net/projects/libusb/files/libusb-1.0/libusb-1.0.9/libusb-1.0.9.tar.bz2"
SBREDIRPATH="http://spice-space.org/download/usbredir/usbredir-0.6.tar.bz2"
PICEPATH="http://spice-space.org/download/releases/spice-0.12.3.tar.bz2"
PICEPROPATH="http://spice-space.org/download/releases/spice-protocol-0.12.6.tar.bz2"
EMUPATH="http://wiki.qemu-project.org/download/qemu-1.4.2.tar.bz2"

if [ -f $USBLIB ]; then
	echo $USBLIB exists
else
	sudo wget $USBLIBPATH 
fi
if [ -f $USBREDIR ]; then
	echo $USBREDIR exists
else
	sudo wget $USBREDIR 
fi
if [ -f $SPICE ]; then
	echo $SPICE exists
else
	sudo wget $SPICE 
fi
if [ -f $SPICEPRO ]; then
	echo $SPICEPRO exists 
else
	sudo wget $SPICEPRO 
fi
if [ -f $QEMU ]; then
	echo $QEMU exists
else
	sudo wget $QEMU 
fi
extract
sudo tar -xf $USBLIB 
sudo tar -xf $USBREDIR 
sudo tar -xf $SPICE 
sudo tar -xf $SPICEPRO 
sudo tar -xf $QEMU 
sudo rm -f $USBLIB $USBREDIR $SPICEPRO $SPICE $QEMU




##################install#######################

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig/
sudo pwd
#install libusb
cd $USBLIB
sudo pwd
sudo ./configure > /dev/null 
sudo make > /dev/null 
sudo make install > /dev/null 
cd ..
sudo rm -rf $USBLIB
#sudo cp /usr/local/lib/pkgconfig/libusb-1.0.pc /usr/lib64/pkgconfig/
#install usbredir
cd $USBREDIR 
sudo pwd
sudo ./configure > /dev/null 
sudo make > /dev/null 
make install > /dev/null 
cd ..
sudo rm -rf $USBREDIR
#install spice protocol
cd $SPICEPRO
sudo pwd
sudo ./configure > /dev/null 
sudo make  > /dev/null 
make install > /dev/null 
cd ..
sudo rm -rf $SPICEPRO
#install spice
cd $SPICE
sudo pwd
sudo ./configure --enable-smartcard --enable-client --enable-opengl > /dev/null  
sudo make > /dev/null  
sudo make install > /dev/null  
cd ..
sudo rm -rf $SPICE
#install qemu
#sudo cp /usr/local/lib/pkgconfig/spice-server.pc /usr/lib64/pkgconfig/
#sudo cp /usr/local/share/pkgconfig/spice-protocol.pc /usr/lib64/pkgconfig/
#sudo cp /usr/local/lib/pkgconfig/libusbredir* /usr/lib64/pkgconfig/
cd $QEMU
sudo ./configure --enable-spice --enable-linux-aio --enable-virtio-blk-data-plane --enable-sdl --enable-usb-redir | grep yes
echo "compiling qemu...."
sudo make > /dev/null
echo "installing qemu...."
sudo make install > /dev/null
cd ..
sudo rm -rf $QEMU 
#add lib path
sudo sed '$a /usr/local/lib/' /etc/ld.so.conf
sudo ldconfig
