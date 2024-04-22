echo "create cluster ..."
sleep 10

sh scripts/setup-k3d-with-argocd.sh

echo "apply deployment ..."
sleep 10

kubectl apply -f confs/deployment.yaml

echo "apply argo deployment ..."
sleep 10
kubectl apply -f confs/argo.yaml

echo "apply service ..."
sleep 10
kubectl apply -f confs/service.yaml


sleep 120
kubectl port-forward -n argocd svc/argocd-server 9000:443 > /dev/null