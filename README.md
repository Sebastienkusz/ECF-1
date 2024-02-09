# ECF-1

# First Step

Add files : Copy the ssh public key of the first user in the folder 
    
    /Packer/files

Verify files

    /Packer/common.auto.pkrvars.hcl
    /Packer/gitlab.pkrvars.hcl
    /Packer/jenkins.pkrvars.hcl

    /Terraform/backend/locals.tf

    /Terraform/gitlab/locals.tf
    /Terraform/gitlab/backend.tf
    /Terraform/gitlab/files/post-install.sh

    /Terraform/jenkins/locals.tf
    /Terraform/jenkins/backend.tf
    /Terraform/jenkins/files/post-install.sh
    /Terraform/jenkins/files/jenkins.conf

## Connexion to Azure

    az login

## Create images 

Go to the packer folder

    cd Packer

    packer init .

_For gitlab_

    packer build -var-file="gitlab.pkrvars.hcl" .

_For jenkins_    

    packer build -var-file="jenkins.pkrvars.hcl" .

## Deployment

Go to the terraform folder

    cd ../Terraform
    

.
### Backend

    $/./Terraform> cd backend

    terraform init

    terraform apply

    
.
### Gitlab

    $/./Terraform> cd gitlab

    terraform init

    terraform apply

See outputs to have the ssh syntax (like this **ssh -i ~/.ssh/admin -p 22 admin@url.com** )

The first connexion 

    ssh -i ~/.ssh/sebastien -p 22 sebastien@gitlab-sebastienk.westeurope.cloudapp.azure.com

exit the VM and copy files in order to finalize the installation

    scp -r ./files/ sebastien@gitlab-sebastienk.westeurope.cloudapp.azure.com:/tmp/

and return to the VM 

    ssh -i ~/.ssh/sebastien -p 22 sebastien@gitlab-sebastienk.westeurope.cloudapp.azure.com 

Run these commands  

    sudo chmod +x /tmp/files/post-install.sh

    sudo /tmp/files/post-install.sh

To know the password of gitlab ( login : root )

    sudo grep '^Password' /etc/gitlab/initial_root_password


.
### Jenkins

    $/./Terraform> cd jenkins

    terraform init

    terraform apply

See outputs to have the ssh syntax (like this **ssh -i ~/.ssh/admin -p 22 admin@url.com** )

The first connexion 

    ssh -i ~/.ssh/sebastien -p 22 sebastien@jenkins-sebastienk.westeurope.cloudapp.azure.com

exit the VM and copy files in order to finalize the installation

    scp -r ./files/ sebastien@jenkins-sebastienk.westeurope.cloudapp.azure.com:/tmp/

and return to the VM 

    ssh -i ~/.ssh/sebastien -p 22 sebastien@jenkins-sebastienk.westeurope.cloudapp.azure.com 

Run these commands  

    sudo chmod +x /tmp/files/post-install.sh

    sudo /tmp/files/post-install.sh

To know the password of jenkins

    sudo cat /var/lib/jenkins/secrets/initialAdminPassword