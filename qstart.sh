#!/bin/sh
#author songtianyi630@163.com
#set -x


switch=br0
tapdevice=$1
spicePort=$2
TLS=$4
vncPort=$3

if [ -n $tapdevice ];then
    if [ ${tapdevice:0:3} = tap ];then
    	#create a tap device
    	/usr/bin/sudo /usr/sbin/tunctl -t $tapdevice
    	/usr/bin/sudo /sbin/ip link set $tapdevice up
   	sleep 0.5s
	#plug tap device into bridge
    	/usr/bin/sudo /usr/sbin/brctl addif $switch $tapdevice
    else
	echo "Error: '$tapdevice' is not a tap device"
	exit 1
    fi
else
    echo "Error: no interface specified"
    exit 1
fi

set -x

#start a guest,note that vnc start from 5900
qemu-system-x86_64 -enable-kvm -localtime -usb\
    -m 2048\
    -cpu host\
    -smp 2\
    -soundhw all\
    -boot c\
    -drive file=/home/usr1/image/win7guest32.img.1 -net nic,model=virtio \
    -net tap,ifname=$tapdevice,vhost=on,vhostforce=on,vnet_hdr=on,script=no,downscript=no\
    -balloon virtio\
    -usbdevice tablet \
    -spice port=$spicePort,image-compression=quic,jpeg-wan-compression=auto,zlib-glz-wan-compression=auto,streaming-video=all,playback-compression=on,disable-ticketing\
    -vga qxl \
    -device  virtio-serial-pci \
    -chardev spicevmc,id=spicechannel0,name=vdagent \
    -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
    -cdrom /home/usr1/iso/virtio-win-0.1-59.iso \
    -readconfig /etc/qemu/ich9-ehci-uhci.cfg \
    -chardev spicevmc,name=usbredir,id=usbredirchardev1 \
    -device usb-redir,chardev=usbredirchardev1,id=usbredirdev1,debug=3 \
    -chardev spicevmc,name=usbredir,id=usbredirchardev2 \
    -device usb-redir,chardev=usbredirchardev2,id=usbredirdev2,debug=3 \
    -chardev spicevmc,name=usbredir,id=usbredirchardev3 \
    -device usb-redir,chardev=usbredirchardev3,id=usbredirdev3,debug=3 \
    -device qxl
#    -monitor stdio 
#    -vnc :$vncPort 
#    -spice tls-port=$TLS,x509-dir=/home/usr1/pki/,tls-channel=main,tls-channel=inputs
#    -device virtio-blk-pci,x-data-plane=on,drive=drive0,scsi=off,config-wce=off\
set +x


#pull out tap device form bridge
sudo brctl delif $switch $tapdevice

#delete tap
sudo tunctl -d $tapdevice

