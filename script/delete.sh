kubectl delete -f ../conf/argo.yml
kubectl delete -f ../conf/service.yml
kubectl delete -f ../conf/deployment.yml

k3d cluster delete p3