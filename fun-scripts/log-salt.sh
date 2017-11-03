#kubectl logs --namespace=salt $(kubectl get pod --namespace=salt -l k8s-app=salt-server -o name|awk '{print $NF}' FS=/)
kubectl logs --namespace=salt $(kubectl get pod --namespace=salt -l k8s-app=salt-server -o name|awk '{print $NF}' FS=/) -f
