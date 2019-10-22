#!/bin/bash

# Install go.
sudo rm -rf /usr/local/go
wget https://dl.google.com/go/go1.13.linux-amd64.tar.gz
sudo tar -C /usr/local/ -zxf go1.13.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Install gcc for go compile.
apt install gcc

# Install docker
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

# Install Kubectl
apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list \\
deb https://apt.kubernetes.io/ kubernetes-xenial main \\
EOF

apt-get update
apt-get install -y kubectl
apt-mark hold kubectl

# Install kind
GO111MODULE="on" go get sigs.k8s.io/kind@v0.5.1
