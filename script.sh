echo "create cluster ..."
sh script/setup-k3d-with-argocd.sh
echo "apply deployment ..."
kubectl apply -f conf/deployment.yml
echo "apply argo deployment ..."
kubectl apply -f conf/argo.yml
echo "apply service ..."
kubectl apply -f conf/service.yml
kubectl port-forward -n argocd svc/argocd-server 9000:443 > /dev/null