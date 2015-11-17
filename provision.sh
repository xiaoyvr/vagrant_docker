#!/bin/sh
#update guest addon
wget http://download.virtualbox.org/virtualbox/5.0.10/VBoxGuestAdditions_5.0.10.iso
sudo mkdir -p /mnt/iso
mount -t iso9660 -o loop VBoxGuestAdditions_5.0.10.iso /mnt/iso/
sudo /mnt/iso/VBoxLinuxAdditions.run
sudo yum -y update
curl -sSL https://get.docker.com/ | sh
sudo yum -y install tmux
sudo yum install bind-utils
sed -i 's/ExecStart=\/usr\/bin\/docker daemon.*/ExecStart=\/usr\/bin\/docker daemon $DOCKER_OPTS/' /usr/lib/systemd/system/docker.service 
grep -q "EnvironmentFile=-/etc/sysconfig/docker" /usr/lib/systemd/system/docker.service || sed -i '/\[Service\]/a\\EnvironmentFile=-/etc/sysconfig/docker' /usr/lib/systemd/system/docker.service
echo 'DOCKER_OPTS="-g /var/lib/docker -H unix:// -H tcp://0.0.0.0:2376 --label provider=virtualbox --tlscacert=/var/docker/config/ssl/certs/ca.pem --tlscert=/var/docker/config/ssl/certs/server.pem --tlskey=/var/docker/config/ssl/private/server-key.pem"'> /etc/sysconfig/docker
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl enable docker
