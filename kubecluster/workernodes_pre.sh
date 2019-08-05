#!/bin/bash

sudo apt-get update
sudo apt-get install -y apt-transport-https curl
sudo cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl

# Update system and install docker

sudo apt-get update
sudo apt-get install
sudo apt install docker.io
