#!/bin/bash

# step1. Install docker
echo "---------------------------"
echo "Step1. Install docker"
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

sleep 2

# step2. Install Kubectl
echo "---------------------------"
echo "Step2. Install kubectl"
sudo apt-get update
sudo apt-get install -y apt-transport-https curl
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo touch /etc/apt/sources.list.d/kubernetes.list
echo deb https://apt.kubernetes.io/ kubernetes-xenial main | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
sudo apt-mark hold kubectl

sleep 2

# step3. Install kind
echo "---------------------------"
echo "Step3. Install kind"

curl -Lo ./kind https://github.com/kubernetes-sigs/kind/releases/download/v0.5.1/kind-$(uname)-amd64
chmod +x ./kind
sudo mv ./kind /usr/bin/kind

sleep 2

# step4. Add master to docker group
echo "---------------------------"
echo "Step4. Add master user to docker group"

sudo groupadd docker
sudo gpasswd -a $USER docker
sudo systemctl restart docker

echo "Install has finished!!"
echo "Please re-login to terminal for applying docker premission."
