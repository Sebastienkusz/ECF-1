#! /bin/sh
set -xe

export APPLI="jenkins"
export DOMAIN="jenkins-sebastienk.westeurope.cloudapp.azure.com"
export ALERTS_EMAIL="kusz.sebastien@gmail.com"

sudo rm /etc/nginx/sites-available/default
sudo mv /tmp/files/$APPLI.conf /etc/nginx/sites-available/default

sudo certbot --nginx --redirect -d $DOMAIN --preferred-challenges http --agree-tos -n -m $ALERTS_EMAIL --keep-until-expiring

sudo systemctl restart nginx