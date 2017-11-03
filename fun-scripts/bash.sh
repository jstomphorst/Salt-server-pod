kubectl exec --namespace=salt $(kubectl get pod --namespace=salt -l k8s-app=salt-server -o name|awk '{print $NF}' FS=/) -ti -- bash
