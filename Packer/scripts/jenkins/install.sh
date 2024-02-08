#! /bin/sh
set -xe

apt-get update
apt install -y fontconfig openjdk-17-jre

wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
apt-get update
apt-get install -y jenkins
systemctl enable jenkins

sudo apt update
sudo apt install -y nginx vim
sudo apt update
sudo apt install -y certbot
sudo apt install -y python3-certbot-nginx
# Validate Nginx configuration
sudo nginx -t
# Start Nginx
sudo systemctl enable --now nginx
sudo systemctl restart nginx

sudo ufw allow 8080/tcp
sudo ufw allow proto tcp from any to any port 80,443
sudo ufw status
