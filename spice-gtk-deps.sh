#!/bin/sh

set -u
set -e

#build spice-gtk
sudo yum -y install gtk-doc
sudo yum -y install libtool
sudo yum -y install perl-Text-CSV
sudo yum -y install pulseaudio-libs-devel
sudo yum -y install libgudev1-devel
sudo yum -y install libacl-devel
