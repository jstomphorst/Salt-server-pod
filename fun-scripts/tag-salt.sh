docker rmi kube-registry.kube-system.svc.cluster.local:31000/salt
docker tag salt kube-registry.kube-system.svc.cluster.local:31000/salt
docker push kube-registry.kube-system.svc.cluster.local:31000/salt
