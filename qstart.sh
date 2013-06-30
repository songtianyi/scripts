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
#install guest
#qemu-system-x86_64 -enable-kvm -localtime -usb\
#    -m 2048\
#    -cpu host\
#    -smp 2\
#    -soundhw all\
#    -boot c\
#    -drive file=/home/usr1/Downloads/ubuntu-server-guest.img,if=virtioi\
#    -net nic,model=virtio\
#    -net tap,ifname=$1\
#    -usbdevice tablet\
#    -vnc :0\
#    -cdrom /home/usr1/Downloads/ubuntu-10.10-server-i386.iso\
#    -spice port=5930,disable-ticketing

#start a guest,note that vnc start from 5900
qemu-system-x86_64 -enable-kvm -localtime -usb\
    -monitor stdio\
    -m 2048\
    -cpu host
    -smp 2\
    -soundhw all\
    -boot d\
    -drive file=/home/usr1/Downloads/win7guest.img,if=virtio\
    -net nic,model=virtio\
    -net tap,ifname=$1,vhost=on,vhostforce=on,vnet_hdr=on\
    -balloon virtio\
    -usbdevice tablet\
    -usbdevice usb-redir
    -spice port=$2,image-compression=quic,jpeg-wan-compression=auto,zlib-glz-wan-compression=auto,streaming-video=all,disable-ticketing\
    -vga qxl\
    -vnc :$3\
    -cdrom /home/usr1/Downloads/virtio-win-0.1-59.iso
#    -device virtio-blk-pci,x-data-plane=on
set +x


#pull out tap device form bridge
sudo brctl delif br0 $1

#delete tap
sudo tunctl -d $1

