sudo apt-get update
sudo apt-get install -y apt-transport-https curl
sudo cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl

# Change root Password
su passwd
su root

# Turnoff Swap
swapoff -a

# Switch to Root User
su root

# Add GPG Key 
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

#Exit root User
exit

# Update system and install docker

sudo apt-get update
sudo apt-get install
sudo apt install docker.io



