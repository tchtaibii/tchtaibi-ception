# get secret pass to connect with argoCD UI
kubectl --namespace argocd get secret argocd-initial-admin-secret -o json 
