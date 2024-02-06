#! /bin/sh
set -xe

apt-get update
apt-get install -y curl openssh-server ca-certificates tzdata perl

cd /tmp
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash

sudo EXTERNAL_URL="http://$FQDN.westeurope.cloudapp.azure.com" apt-get install gitlab-ee
