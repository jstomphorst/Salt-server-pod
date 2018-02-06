# Salt-server-pod
A kubernetes pod and services for salt-server
In this docker i've created the salt stack master process and the sshd deamon

The pod is runnning in his own namespace "salt"


docker build -t salt .

docker tag salt kube-registry.kube-system.svc.cluster.local:31000/salt
docker push kube-registry.kube-system.svc.cluster.local:31000/salt

docker run  --name salt salt
sudo docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs sudo docker rm

kubectl create -f salt-run.yaml

kubectl describe --namespace=salt $(kubectl get pod --namespace=salt -l k8s-app=salt-server -o name)

kubectl logs --namespace=salt $(kubectl get pod --namespace=salt -l k8s-app=salt-server -o name|awk '{print $NF}' FS=/) -f

kubectl exec --namespace=salt $(kubectl get pod --namespace=salt -l k8s-app=salt-server -o name|awk '{print $NF}' FS=/) -ti -- bash


things you need:
build you docker and upload it to your registry
change the root password is now password
we need persistend storage on kubernetes I am using NFS, so create a nfs share and change the yaml file.



todo : 
Add certificates
Add users 
upload docker to dockerhub
and more
