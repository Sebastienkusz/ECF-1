# ECF-1

# First Step

Verify files

    /Packer/common.auto.pkrvars.hcl
    /Terraform/backend/locals.tf
    /Terraform/gitlab/locals.tf
    /Terraform/gitlab/backend.tf
    /Terraform/jenkins/locals.tf
    /Terraform/jenkins/backend.tf

## Connexion to Azure

    az login

## Create images 

Go to the packer folder

    cd Packer

    packer build -var-file="gitlab.pkrvars.hcl" .

    packer build -var-file="jenkins.pkrvars.hcl" .

## Deployment

Go to the terraform folder

    cd ../Terraform

### Gitlab

    cd gitlab

    terraform init

    terraform apply

### Jenkins

    cd jenkins

    terraform init

    terraform apply