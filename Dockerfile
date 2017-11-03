FROM centos:7

RUN rpm --import https://repo.saltstack.com/yum/redhat/7/x86_64/latest/SALTSTACK-GPG-KEY.pub

RUN touch /etc/yum.repos.d/saltstack.repo && \
    echo "[saltstack-repo]" >> /etc/yum.repos.d/saltstack.repo && \
    echo "name=SaltStack repo for RHEL/CentOS \$releasever" >> /etc/yum.repos.d/saltstack.repo  && \
    echo "baseurl=https://repo.saltstack.com/yum/redhat/\$releasever/\$basearch/2017.7" >> /etc/yum.repos.d/saltstack.repo && \
    echo "enabled=1" >> /etc/yum.repos.d/saltstack.repo && \
    echo "gpgcheck=1" >> /etc/yum.repos.d/saltstack.repo && \
    echo "gpgkey=https://repo.saltstack.com/yum/redhat/\$releasever/\$basearch/2017.7/SALTSTACK-GPG-KEY.pub" >> /etc/yum.repos.d/saltstack.repo

RUN yum clean expire-cache && \
    yum update -y && \

    # Salt and prerequisites
    yum install -y salt-master  \
                   salt-minion  \
                   salt-ssh     \
                   salt-syndic  \
                   salt-cloud   \
                   virt-what    \
                   git    \
                   tmux    \
                   vim    \
                   dmidecode && \

    # Additional tools
    yum install -y epel-release && \
    yum install -y python-pip openssh-server
# net-tools nmap git

    #install pip for supervisor and upgrade
RUN pip install --upgrade pip 
#&& \
 #   pip install GitPython && \

    # SSHD 
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor && \
    echo 'root:password' | chpasswd && \
    sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    /usr/bin/ssh-keygen -A  #  todo Keys to disk.. but not now..

#cleanup
RUN yum clean all &&\
    rm -rf /var/cache/yum

    # Supervisor
RUN  /usr/bin/pip install supervisor
    #config supervisor
RUN mkdir -p /var/log/supervisor
COPY files/supervisord.conf /etc/supervisor/supervisord.conf
COPY files/start.sh /

#copy original config to "backup" dir and use this when er no initial config is.
RUN mkdir /var/salt-org && \
    cp -p /etc/salt/* /var/salt-org/ -R


# Ports to expose
EXPOSE 22 4505 4506

#ENTRYPOINT  ["/usr/bin/supervisord"]
ENTRYPOINT  ["/start.sh"]

