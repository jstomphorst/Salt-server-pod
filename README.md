# Salt-server-pod
A kubernetes pod and services for salt-server
In this docker i've created the salt stack master process and the sshd deamon




things you need:
build you docker and upload it to your registry
change the root password is now password
we need persistend storage on kubernetes I am using NFS, so create a nfs share and change the yaml file.



todo : 
Add certificates
Add users 
upload docker to dockerhub
and more
