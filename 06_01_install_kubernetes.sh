#!/bin/bash

## 02_01_install_openjdk on ubuntu

############### Installing KUBERNETES, K8s ##############################

# Let's try to use advices at following articles to have installed 4 main tools/components:

#Docker = a container runtime. It is the component that runs your containers.
#         Support for other runtimes such as rkt is under active development in Kubernetes.
#kubectl = a CLI tool used for issuing commands to the cluster through its API Server.
#kubeadm = a CLI tool that will install and configure the various components of a cluster in a standard way.
#kubelet = a system service/program that runs on all nodes and handles node-level operations.

# Let's try to use following commands to prepare and install K8s:

sudo systemctl enable docker

sudo apt install -y curl

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add

sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

sudo apt install -y kubeadm

kubeadm version

sudo swapoff -a

sudo hostnamectl set-hostname master-node

sudo hostnamectl set-hostname slave-node

sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# Your Kubernetes control-plane has initialized successfully now!
# To start using your cluster, you need to run the following as a regular user:

mkdir -p $HOME/.kube

sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

sudo chown $(id -u):$(id -g) $HOME/.kube/config

sudo kubectl get nodes

# You should now deploy a pod network to the cluster.
# Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
# Calico from https://kubernetes.io/docs/concepts/cluster-administration/addons/
# Install network plugin (Calico) - these now seem to leave the nodes in a "notReady" state,
# below is a fix from https://github.com/CESNET/jupyter-meta/wiki/Kubernetes-with-Kubeadm

sudo kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/installation/hosted/rbac-kdd.yaml

sudo kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/installation/hosted/kubernetes-datastore/calico-networking/1.7/calico.yaml

sudo kubectl apply -f https://docs.projectcalico.org/v3.11/manifests/calico.yaml

sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# Then you can join any number of worker nodes by running the following on each as root:

#sudo kubeadm join 192.168.1.22:6443 --token wv9d86.mfssvpdndne1e96h \
#    --discovery-token-ca-cert-hash sha256:392ee523f3a93648a019880cb38f1cad7532be9a1e0edcb63e9a478d880bc33a

kubectl get pods --all-namespaces

sudo kubectl get nodes

sudo apt install -y net-tools

ifconfig

ps -ef | grep kubectl

# Then you can join any number of worker nodes by running the following on each as root:

#sudo kubeadm join 192.168.1.22:6443 --token wv9d86.mfssvpdndne1e96h \
#    --discovery-token-ca-cert-hash sha256:392ee523f3a93648a019880cb38f1cad7532be9a1e0edcb63e9a478d880bc33a
