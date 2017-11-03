kubectl describe --namespace=salt $(kubectl get pod --namespace=salt -l k8s-app=salt-server -o name)
