#!/bin/bash

#install essential  tools
sudo yum -y install mingw32-gcc
sudo yum -y install wget


sudo yum -y install mingw32-glib2-devel
sudo yum -y install mingw32-pixman
sudo yum -y install mingw32-celt051
sudo yum -y install mingw32-openssl
sudo yum -y install mingw32-libxml2 
sudo yum -y install mingw32-gtk2 mingw32-gtk3 mingw32-gtk-vnc
#sudo yum -y install polkit*
#sudo yum -y install boost*
##自己编译安装boost
#sudo yum -y install python-devel
##自己编译安装bzip2
PKG_CONFIG_PATH=/usr/lib64/pkgconfig/:/usr/local/lib/pkgconfig/
#download source
if [ -f "virt-viewer-0.5.6.tar.bz2" ]; then
    echo "virt-viewer-0.5.6.tar.bz2 exists"
else
    sudo wget https://git.fedorahosted.org/cgit/virt-viewer.git/snapshot/virt-viewer-0.5.6.tar.bz2
fi

sudo tar -xf virt-viewer-0.5.6.tar.bz2  
cd virt-viewer-0.5.6
sudo mingw32-configure
