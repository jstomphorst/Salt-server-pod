#!/bin/bash
echo "starting container"
echo "is the /etc/salt config there?"


if [ -f /etc/salt/master ]; then
   echo "File $FILE exists."
else
   echo "File $FILE does not exist."
   cp /var/salt-org/* /etc/salt/ -R
fi
echo PermitRootLogin yes >> /etc/ssh/sshd_config
echo LogLevel INFO >> /etc/ssh/sshd_config

echo start saltmaster

#/usr/bin/salt-master -l debug 

salt-master --versions
echo starting supervisor
/usr/bin/supervisord
