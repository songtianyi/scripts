#!/bin/sh

set -u
set -e

#build spice-gtk
sudo yum -y install gtk-doc
sudo yum -y install libtool
sudo yum -y install intltool
sudo yum -y install perl-Text-CSV
sudo yum -y install pulseaudio-libs-devel
sudo yum -y install libgudev1-devel
sudo yum -y install libacl-devel
sudo yum -y install spice-gtk3-devel
sudo yum -y install polkit-devel
sudo yum -y install gobject-introspection-devel
sudo yum -y install vala-tools
sudo yum -y install dbus-glib-devel
