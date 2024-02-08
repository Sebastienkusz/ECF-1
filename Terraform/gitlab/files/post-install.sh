#! /bin/sh
set -xe

export URL="gitlab-sebastienk.westeurope.cloudapp.azure.com"
export ALERTS_EMAIL="kusz.sebastien@gmail.com"

sudo sed -i '/external_url/ s/^/# /' /etc/gitlab/gitlab.rb

sudo tee -a /etc/gitlab/gitlab.rb <<EOF
## GitLab instance
external_url 'https://$URL' 
letsencrypt['contact_emails'] = ['$ALERTS_EMAIL'] # Optional
letsencrypt['enable'] = true
letsencrypt['auto_renew'] = true
EOF

sudo gitlab-ctl reconfigure

sudo gitlab-ctl restart