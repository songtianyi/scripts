#!/bin/bash -e


#fedora cross repo
sudo wget http://build1.vanpienbroek.nl/fedora-cross/fedora-cross.repo
sudo mv -f fedora-cross.repo /etc/yum.repos.d/

#essential  tools
sudo yum -y install mingw32-gcc
sudo yum -y install wget

#dependencies
sudo yum -y install mingw32-filesystem
sudo yum -y install mingw32-glib2
sudo yum -y install mingw32-gstreamer-plugins-bad-free
sudo yum -y install mingw32-gstreamer-plugins-good
sudo yum -y install mingw32-gtk2
sudo yum -y install mingw32-gtk3 
sudo yum -y install mingw32-libusbx
sudo yum -y install mingw32-libvirt
sudo yum -y install mingw32-libxml2
sudo yum -y install mingw32-gtk-vnc
sudo yum -y install mingw32-readline
sudo yum -y install mingw32-spice-glib
sudo yum -y install mingw32-spice-gtk
sudo yum -y install mingw32-usbredir
sudo yum -y install pkgconfig
sudo yum -y install intltool
sudo yum -y install icoutils
sudo yum -y install dos2unix
sudo yum -y install hicolor-icon-theme
sudo yum -y install gnome-icon-theme
sudo yum -y install msitools
sudo yum -y install mingw32-pixman
sudo yum -y install mingw32-celt051
sudo yum -y install mingw32-openssl

##64 bit
#sudo yum -y install mingw64-filesystem
#sudo yum -y install mingw64-glib2
#sudo yum -y install mingw64-gstreamer-plugins-bad-free
#sudo yum -y install mingw64-gstreamer-plugins-good
#sudo yum -y install mingw64-gtk2
#sudo yum -y install mingw64-gtk3
#sudo yum -y install mingw64-libusbx
#sudo yum -y install mingw64-libvirt
#sudo yum -y install mingw64-libxml2
#sudo yum -y install mingw64-gtk-vnc
#sudo yum -y install mingw64-readline
#sudo yum -y install mingw64-spice-gtk
#sudo yum -y install mingw64-spice-glib
#sudo yum -y install mingw64-usbredir
#sudo yum -y install mingw64-pixman
#sudo yum -y install mingw64-celt051
#sudo yum -y install mingw64-openssl




VIRTVIEWERPATH="https://git.fedorahosted.org/cgit/virt-viewer.git/snapshot/virt-viewer-0.5.6.tar.bz2"
VIRTVIEWERPACKAGE=${VIRTVIEWERPATH##*/}
#download source
if [ -f "$VIRTVIEWERPACKAGE" ]; then
    echo "$VIRTVIEWERPACKAGE exists"
else
    sudo wget $VIRTVIEWERPATH 
fi

sudo tar -xf $VIRTVIEWERPACKAGE 
cd virt-viewer-0.5.6
./autogen.sh
mingw32-configure --with-gtk=2.0 --with-audio=gstreamer --enable-usbredir=yes --with-spice-gtk --with-gtk-vnc
