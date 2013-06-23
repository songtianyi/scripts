#!/bin/sh
#set -x


switch=br0
tapdevice=$1
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

#start a guest,note that vnc start from 5900
set -x
qemu-system-x86_64 -m 2048 -enable-kvm -cpu host -smp 2 -soundhw all -boot c -drive file=/home/usr1/Downloads/win7guest.img -net nic,model=virtio -net tap,ifname=$1 -localtime -usbdevice tablet -usb -spice port=5930,disable-ticketing -vga qxl -vnc :0 -monitor stdout
set +x


#pull out tap device form bridge
sudo brctl delif br0 $1

#delete tap
sudo tunctl -d $1

