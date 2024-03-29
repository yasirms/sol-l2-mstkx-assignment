#!/bin/bash

# filename: install_helm.sh
### Install Helm
cd ~
sudo curl -LO https://git.io/get_helm.sh
sudo chmod 700 get_helm.sh
sudo ./get_helm.sh

### Install and initialize Tiller

sudo helm init 

# Install an app in Kubernetes Cluster with helm

sudo helm install --name consul-app stable/consul