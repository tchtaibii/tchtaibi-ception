#!/bin/bash
# install k3d in machine
if which k3d;then
    echo "K3d is already installed"
else
    wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
fi
# create k3s cluster with k3d
k3d cluster create p3 -p "8081:30001@agent:0" --agents 1
# create two namespaces one for  app and the second for argocd
kubectl create ns argocd
kubectl create ns dev
# install argocd inside namespace argocd
kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml -n argocd
