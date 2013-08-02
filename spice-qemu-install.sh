#!/bin/sh




#author songtianyi630@163.com

#------------------------------------------
#This script has been tested in flowing env
#OS=fedora 15, kernel=2.6.43
#------------------------------------------


set -u

#
#######################essential tools#############
#
##network tools 
#sudo yum -y install wget
##compile tools
#sudo yum -y install make
#sudo yum -y install gcc gcc-c++
#sudo yum -y install autoconf
#
#
#
#
###################spice###########################
#
#sudo yum -y install glib2-devel
#sudo yum -y install zlib-devel
#sudo yum -y install pixman-devel
#sudo yum -y install celt051-devel
#sudo yum -y install pyparsing
#sudo yum -y install alsa-lib-devel
#sudo yum -y install openssl-devel
#sudo yum -y install libcacard-devel 
#sudo yum -y install cairo-devel 
#sudo yum -y install cyrus-sasl-devel
#sudo yum -y install libjpeg-turbo-devel
#sudo yum -y install libudev-devel
##if you wanna enable gui,cegui is needed
##when you compile cegui, freetype2 and libpcre must be installed
#sudo yum -y install freetype-devel
#sudo yum -y install pcre-devel
#
#
#
#
####################qemu#########################
#
##install VNC
#sudo yum -y install vnc
##install libaio-devel to enable linux-AIO
#sudo yum -y install libaio-devel
##install SDL-devel to enable SDL
#sudo yum -y install SDL-devel
#




#############Download and extract files########

#specify package url path
USBLIBPATH="http://downloads.sourceforge.net/libusbx/libusbx-1.0.16.tar.bz2"
USBLIB_COMPILE_OPTION=""
USBREDIRPATH="http://spice-space.org/download/usbredir/usbredir-0.6.tar.bz2"
USBREDIR_COMPILE_OPTION=""
SPICEPROPATH="http://spice-space.org/download/releases/spice-protocol-0.12.6.tar.bz2"
SPICEPRO_COMPILE_OPTION=""
SPICEPATH="http://spice-space.org/download/releases/spice-0.12.4.tar.bz2"
SPICE_COMPILE_OPTION="--enable-smartcard --enable-client --enable-opengl"
QEMUPATH="http://wiki.qemu-project.org/download/qemu-1.4.2.tar.bz2"
QEMU_COMPILE_OPTION="--enable-spice --enable-linux-aio --enable-virtio-blk-data-plane --enable-sdl --enable-usb-redir"

#package download url array
URL=($USBLIBPATH $USBREDIRPATH $SPICEPROPATH $SPICEPATH $QEMUPATH)
#compile options array
COMPILE_OPTION[0]=$USBLIB_COMPILE_OPTION
COMPILE_OPTION[1]=$USBREDIR_COMPILE_OPTION
COMPILE_OPTION[2]=$SPICEPRO_COMPILE_OPTION
COMPILE_OPTION[3]=$SPICE_COMPILE_OPTION
COMPILE_OPTION[4]=$QEMU_COMPILE_OPTION


#add lib path
echo "/usr/local/lib/" >> /etc/ld.so.conf
awk '!a[$0]++' /etc/ld.so.conf > /etc/ld.so.conf.tmp
sudo mv -f /etc/ld.so.conf.tmp /etc/ld.so.conf
sudo ldconfig

#check dir
if [  -d /usr/local/lib/pkgconfig -a -d /usr/lib64/pkgconfig -a /usr/local/share/pkgconfig ]; then
	echo check dir....yes
else
	echo check /usr/local/lib/pkgconfig /usr/lib64/pkgconfig /usr/local/share/pkgconfig failed!
	exit 1
fi

SUFFIX="-install-dir"
count=0

for cur in ${URL[@]}
do
	package=${cur##*/}
	if [ -f $package ]; then
		echo $package exists
	else
		wget $cur
	fi

	if [ ! -d $package$SUFFIX ]; then
		mkdir $package$SUFFIX
		tar -xf $package -C $package$SUFFIX
	fi

	#configure
	cd $package$SUFFIX
	cd  `ls -L | grep "^."`
	echo "`pwd` #sudo ./configure ${COMPILE_OPTION[$count]} | grep -i error"
	echo ------------error info ----------------
	sudo  ./configure ${COMPILE_OPTION[$count]} | grep -i error
	echo ------------===========----------------
	echo 
	
	#make & make install
	
	read -n1 -p "CONTINUE to make and make install?[Y?N]" answer
	case "$answer" in
		Y|y) echo "OK, to make and make install";;
		*)	echo "exit"
			exit;;
	esac

	sudo  make > /dev/null | grep -i error
	sudo  make install > /dev/null | grep -i error

	case "$count" in
		0) sudo cp /usr/local/lib/pkgconfig/libusb-1.0.pc /usr/lib64/pkgconfig/ ;;
		2) sudo cp /usr/local/share/pkgconfig/spice-protocol.pc /usr/lib64/pkgconfig/ ;;
		3) sudo cp /usr/local/lib/pkgconfig/spice-server.pc /usr/lib64/pkgconfig/
		   sudo cp /usr/local/lib/pkgconfig/libusbredir* /usr/lib64/pkgconfig/ ;;
	esac

	cd ../../
	rm -rf $package$SUFFIX
	rm -f $package
	count=$[ $count + 1 ]	
done

