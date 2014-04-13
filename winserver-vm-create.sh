#!/bin/sh
echo windows server 镜像制作脚本
echo [script] 1 \#安装Windows操作系统
echo [script] 2 \#安装驱动
if [ $1 -eq 1 ]; then
	qemu-img create -f qcow2 Windows-2008-32.img -opreallocation=metadatac 40G
	virsh create 2008-32.xml
	virsh vncdisplay 2008-32
	echo 用vncviewer连接虚拟机，安装操作系统，设置管理员密码为ucloud.cn, 关闭虚拟机

else if [ $1 -eq 2 ]; then
	#创建一个img，辅助virtio的安装
	qemu-img create -f qcow2 fake.img 1G

	#下载virtio驱动和powershell
	power=http://download.microsoft.com/download/F/9/E/F9EF6ACB-2BA8-4845-9C10-85FC4A69B207/Windows6.0-KB968930-x86.msu
	url=http://alt.fedoraproject.org/pub/alt/virtio-win/stable/virtio-win-0.1-52.iso
	virtio=${url##*/}
	powershell=${power##*/}

	#下载文件
	if [ ! -f $virtio ]; then
		wget $url
	fi
	if [ ! -f $powershell ]; then
		wget $power
	if
	
	#挂载virtio驱动的iso文件
	mkdir $virtio.dir
	mount -t -o loop $virtio $virtio.dir
	
	#挂载img
	mkdir img_dir
	guestmount -a Windows-2008-32.img -i img_dir

	#将数据拷贝到img里边
	mkdir img_dir/Drivers
	mkdir img_dir/Drivers/VirtIO/
	mv $virtio.dir/* img_dir/Drivers/VirtIO/
	mv $powershell img_dir/

	#取消挂载
	umount img_dir 
	umount $virtio.dir

	#清理文件
	rm -rf img_dir $virtio.dir $virtio $powershell 

	#启动虚拟机
	virsh create 2008-32.xml
	virsh vncdisplay 2008-32
	echo 启动系统，安装网卡驱动和磁盘驱动,安装powershell，完成剩下的手工配置。
fi

