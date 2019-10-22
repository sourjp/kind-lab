#!/bin/bash

echo "---------------------------------"
echo "Let's build own k8s cluster by kind!"
echo "Please tell me your Login ID and Password. You can use A-Z,a-z,0-9."
read -p "Login ID: " LOGIN_USER
read -p "Password: " LOGIN_PASSWORD
echo ""
echo "Next, Which cluster type do you need?"
echo "  kind 1: 1 master node. This is useful if you would like to just touching k8s."
echo "  kind 2: 1 master, and 2 worker nodes. I recommend this cluster if you would like to learn k8s seriously."
echo ""
echo "Please type kind's number.(e.g. 1)"
read -p "Cluster type: " CLUSTER_NUMBER

CLUSTER_NAME=$LOGIN_USER"_k8s" 

# Define cluster type
if [ $CLUSTER_NUMBER -eq 1 ]; then
    CLUSTER_TYPE=~/kind-lab/single-cluster.yaml

elif [ $CLUSTER_NUMBER -eq 2 ]; then
    CLUSTER_TYPE=~/kind-lab/simple-cluster.yaml

fi

# step1. Make Login account and home directory for using 
CHECK_USER=$(cat /etc/passwd | grep -o $LOGIN_USER | awk NR==1)

if [ $CHECK_USER = $LOGIN_USER ]; then
    echo "You already have your ID, Please access previous password after k8s cluster has created. If you forgot, please change or delete password by yourself."

else
    sudo useradd -m $LOGIN_USER -p $LOGIN_PASSWORD -s /bin/bash

fi

sleep 2

# step2. Make k8s cluster.
sudo kind create cluster --name $CLUSTER_NAME --config $CLUSTER_TYPE

sleep 2

# step3. Set KUBECONFIG for accessing to k8s cluster.
echo -n "export KUBECONFIG="$(kind get kubeconfig-path --name=$CLUSTER_NAME)” | sudo tee /home/$LOGIN_USER/.bash_profile
sudo mkdir /home/$LOGIN_USER/.kube/
sudo mv -f ~/.kube/kind-config-$CLUSTER_NAME /home/$LOGIN_USER/.kube/

echo "Now you can access to your k8s cluster!"
echo "Please login terminal as '$LOGIN_USER' and press 'kubectl get node'."
echo "Enjoy k8s life!"
echo "---------------------------------"