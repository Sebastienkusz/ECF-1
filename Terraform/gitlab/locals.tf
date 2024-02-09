# General variables 
locals {
  subscription_id     = "c56aea2c-50de-4adc-9673-6a8008892c21"
  resource_group_name = "Sebastien_K"
  location            = data.azurerm_resource_group.main.location
  application         = basename(abspath(path.root))
}

# Network variables
locals {
  network_europe = ["10.1.0.0/16"]
  subnets_europe = ["10.1.1.0/24"]
}

# Virtual machine variables
locals {
  public_ip_allocation_method = "Static"
  vm_domain_name_label        = "${local.application}-${lower(replace(local.resource_group_name, "_", ""))}"
  public_ip_sku               = "Standard"

  image_os = "${lower(replace(local.resource_group_name, "_", ""))}-${local.application}"

  os_image_version = "1.0.0"

  vm_size  = "Standard_B4ls_v2"
  ssh_port = "22"

  os_disk_caching           = "ReadWrite"
  os_disk_create_option     = "FromImage"
  os_disk_managed_disk_type = "Standard_LRS"

  ip_simplon = "82.126.234.200"

  admin_username = "adminuser"
  path           = "/home/${local.admin_username}/.ssh/authorized_keys"
  ssh_key        = tls_private_key.admin_rsa.public_key_openssh

  ssh_ip_filter = concat([for user_value in local.users : user_value.ip], [local.ip_simplon])
}

# Add users 
locals {
  users = {
    sebastien = {
      private_ssh_key_name = "sebastien"
      ip                   = "83.195.211.184"
    }
  }
}

