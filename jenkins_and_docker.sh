#!/bin/bash
echo "Installing java packages"
sudo yum install java -y
echo "Adding keys"
##commands to install jenkins
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
pushd /etc/yum.repos.d/
sudo curl -O https://pkg.jenkins.io/redhat-stable/jenkins.repo
popd
sudo yum install jenkins -y
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo systemctl enable firewalld --now
sudo firewall-cmd --state
sudo firewall-cmd --add-port=8080/tcp --permanent
sudo firewall-cmd --reload
sleep 1m
echo "Installing Jenkins Plugins"
JENKINSPWD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
echo $JENKINSPWD
##steps to install docker packages on centos8
echo "installation of Docker"
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install docker-ce --nobest -y
sudo systemctl enable --now docker
systemctl status docker
sudo usermod -aG docker $USER
sudo usermod -aG docker jenkins
docker pull alpine