resource "azurerm_public_ip" "main" {
  name                = "${var.application_name}-vm-ip"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = var.public_ip_allocation_method
  domain_name_label   = var.domain_name_label
  sku                 = var.public_ip_sku
}

resource "azurerm_network_interface" "main" {
  name                = "${var.application_name}-vm-nic"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "${var.application_name}-vm-ip-config"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

resource "azurerm_network_security_group" "main" {
  name                = "${var.application_name}-vm-nsg"
  location            = var.location
  resource_group_name = var.resource_group
}

resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

# Règle de sécurité pour le port (SSH) depuis n'importe quelle source sur la VM
resource "azurerm_network_security_rule" "ssh" {
  name                        = "Allow-SSH-Inbound"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = var.ssh_port
  source_address_prefixes     = var.ssh_ip_filter
  destination_address_prefix  = azurerm_network_interface.main.private_ip_address
  resource_group_name         = var.resource_group
  network_security_group_name = azurerm_network_security_group.main.name
}

# Règle de sécurité pour le port 80 (HTTP) depuis n'importe quelle source sur la VM
resource "azurerm_network_security_rule" "NSG_Appli_Rules_HTTP" {
  name                        = "HTTP_Rule"
  priority                    = 120
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = var.application_port
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group
  network_security_group_name = azurerm_network_security_group.main.name
}

# data "azurerm_images" "search_os" {
#   resource_group_name = var.resource_group
#   tags_filter = var.os_image_tags 
# }

data "azurerm_image" "search_os" {
  name_regex          = "^${var.image_os}-\\d*"
  sort_descending     = true
  resource_group_name = var.resource_group
}

# resource "azurerm_image" "os_image" {
#   name                          = "${data.azurerm_image.search_os.name_regex}"
#   location                      = var.location
#   resource_group_name           = var.resource_group
#   tags = var.os_image_tags
# }  

resource "azurerm_virtual_machine" "main" {
  name                          = "${var.application_name}-vm"
  location                      = var.location
  resource_group_name           = var.resource_group
  network_interface_ids         = [azurerm_network_interface.main.id]
  vm_size                       = var.vm_size
  delete_os_disk_on_termination = true


  storage_os_disk {
    name              = "${var.application_name}-vm"
    caching           = var.os_disk_caching
    create_option     = var.os_disk_create_option
    managed_disk_type = var.os_disk_managed_disk_type
  }

  storage_image_reference {
    id = data.azurerm_image.search_os.id
    #   publisher = var.image_publisher
    #   offer     = var.image_offer
    #   sku       = var.image_sku
    #   version   = var.image_version
  }

  os_profile {
    computer_name  = "${replace(var.application_name, "_", "")}-vm"
    admin_username = var.admin_username
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = var.path
      key_data = var.ssh_key
    }
  }
}
