#!/bin/sh
set -x


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

#start a guest
#qemu-kvm -m 1024 -soundhw all -boot c -drive file=xpguest.img -net nic,model=virtio -cpu host -net tap,ifname=$1 -localtime
qemu-system-x86_64 -m 2048 -enable-kvm -soundhw all -boot c -drive file=/home/usr1/Downloads/win7guest.img -net nic -net tap,ifname=$1 -localtime -usbdevice tablet -spice port=5931,disable-ticketing -vga qxl -vnc :3

#qemu-system-x86_64 -name i-2-37-VM  -M pc-1.3 -enable-kvm -m 2048 -smp 2,sockets=2,cores=1,threads=1 -uuid 00399e6f-69df-3008-9035-7cedacd25dea -nodefconfig -nodefaults -rtc base=localtime,driftfix=slew  -device piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2 -drive file=/home/usr1/Downloads/win7guest.img -device ide-drive,bus=ide.0,unit=0,drive=drive-ide0-0-0,id=ide0-0-0,bootindex=2 -device isa-serial,chardev=charserial0,id=serial0 -device usb-tablet,id=input0 -vnc 0.0.0.0:3 -vga qxl -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x4   -net nic,name="vnet1",model=rtl8139,addr=0x5 -spice port=5930,disable-ticketing

#pull out tap device form bridge
sudo brctl delif br0 $1

#delete tap
sudo tunctl -d $1

