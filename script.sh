echo "create cluster ..."
sh script/setup.sh
echo "apply deployment ..."
kubectl apply -f conf/deployment.yml
echo "apply argo deployment ..."
kubectl apply -f conf/argo.yml
echo "apply service ..."
kubectl apply -f conf/service.yml
sleep 2

kubectl patch service argocd-server -n argocd --type='json' -p '[{"op":"replace","path":"/spec/type","value":"NodePort"}]'
# sleep 2
# kubectl port-forward -n argocd svc/argocd-server 9000:443 &

# # Save the process ID of the port-forward command
# port_forward_pid=$!

# # Wait for termination signal
# trap "kill $port_forward_pid" EXIT

# # Sleep indefinitely to keep the script running
# sleep infinity