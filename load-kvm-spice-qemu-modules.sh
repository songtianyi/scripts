#!/bin/bash
#set +x

###############spice,kvm or qemu################

#load some module,always needed afther you restart your system
sudo modprobe tun
sudo modprobe vhost-net
sudo modprobe virtio_net
sudo modprobe virtio_blk
sudo modprobe kvm
sudo modprobe kvm_intel
#when you meet Failed to open /dev/dsp oss: No such file or Directory problem
sudo modprobe snd_pcm_oss




###############################################

