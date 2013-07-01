#!/bin/bash
#set +x
VIRTVIEWER="virt-viewer-0.5.6.tar.gz"
VIRTVIEWERPATH="http://virt-manager.et.redhat.com/download/sources/virt-viewer/virt-viewer-0.5.6.tar.gz"
if [-f $VIRTVIEWER ]; then
    echo $VIRTVIEWER exists
else
    sudo wget $VIRTVIEWERPATH 
fi
sudo tar -xf $VIRTVIEWER 
sudo rm -f $VIRTVIEWER 
