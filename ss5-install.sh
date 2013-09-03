#!/bin/sh
#author songtianyi630@163.com

#------------------------------------------
#This script has been tested in flowing env
#OS=fedora 15, kernel=2.6.43
#OS=fedora 19, kernel=3.9.5
#------------------------------------------

set -u

#######################deps#######################
sudo yum -y install pam-devel openldap-devel cyrus-sasl-devel gcc automake make openssl openssl-devel wget

#############Download and extract files########
SOCKET_SERVER_PATH="http://hivelocity.dl.sourceforge.net/project/ss5/ss5/3.8.9-8/ss5-3.8.9-8.tar.gz"

SUFFIX="-install-dir"

package=${SOCKET_SERVER_PATH##*/}

if [ -f $package ]; then
	echo $package exists
else
	wget $SOCKET_SERVER_PATH
fi

if [ ! -d $package$SUFFIX ]; then
	mkdir $package$SUFFIX
	tar -xf $package -C $package$SUFFIX
fi

#configure
cd $package$SUFFIX
cd  `ls -L | grep "^."`

	read -n1 -p "CONTINUE to make and make install?[Y?N]" answer
	case "$answer" in
		Y|y) echo "OK, to make and make install";;
		*)	echo "exit"
			exit;;
	esac

./configure --with-mysql
make
sudo make install
cd ../../
rm -rf $package$SUFFIX
rm -f $package

