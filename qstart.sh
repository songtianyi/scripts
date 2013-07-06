#!/bin/sh
#set -x


switch=br0
tapdevice=$1
spiecPort=$2
vncPort=$3

if [ -n $tapdevice ];then
    if [ ${tapdevice:0:3} = tap ];then
    	#create a tap device
    	/usr/bin/sudo /usr/sbin/tunctl -t $1
    	/usr/bin/sudo /sbin/ip link set $1 up
   	sleep 0.5s
	#plug tap device into bridge
    	/usr/bin/sudo /usr/sbin/brctl addif $switch $1
    else
	echo "Error: '$1' is not a tap device"
	exit 1
    fi
else
    echo "Error: no interface specified"
    exit 1
fi

set -x

#start a guest,note that vnc start from 5900
qemu-system-x86_64 -enable-kvm -localtime -usb\
    -monitor stdio\
    -m 2048\
    -cpu host\
    -smp 4,sockets=1,cores=2\
    -soundhw all\
    -boot d\
    -drive file=/home/usr1/Downloads/win7guest.img,if=virtio -net nic,model=virtio \
    -net tap,ifname=$1,vhost=on,vhostforce=on,vnet_hdr=on,script=no,downscript=no\
    -balloon virtio\
    -usbdevice tablet \
    -spice port=$2,image-compression=quic,jpeg-wan-compression=auto,zlib-glz-wan-compression=auto,streaming-video=all,playback-compression,disable-ticketing\
    -vga qxl\
    -device  virtio-serial-pci \
    -chardev spicevmc,id=spicechannel0,name=vdagent \
    -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
    -cdrom /home/usr1/Downloads/virtio-win-0.1-59.iso \
    -readconfig /etc/qemu/ich9-ehci-uhci.cfg \
    -chardev spicevmc,name=usbredir,id=usbredirchardev1 \
    -device usb-redir,chardev=usbredirchardev1,id=usbredirdev1,debug=3 \
    -chardev spicevmc,name=usbredir,id=usbredirchardev2 \
    -device usb-redir,chardev=usbredirchardev2,id=usbredirdev2,debug=3 \
    -chardev spicevmc,name=usbredir,id=usbredirchardev3 \
    -device usb-redir,chardev=usbredirchardev3,id=usbredirdev3,debug=3 \
    -vnc :$3
#    -device virtio-blk-pci,x-data-plane=on,drive=drive0,scsi=off,config-wce=off\
set +x


#pull out tap device form bridge
sudo brctl delif br0 $1

#delete tap
sudo tunctl -d $1

