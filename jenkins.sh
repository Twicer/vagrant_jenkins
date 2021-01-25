#!/bin/bash
echo "Installing java packages"
sudo yum install java -y
echo "Adding keys"
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
echo "Install Maven"
sudo yum install maven -y
mvn -version
echo "Installing Jenkins Plugins"
JENKINSPWD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
echo $JENKINSPWD