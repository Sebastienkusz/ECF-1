resource "azurerm_storage_account" "tfstate" {
  name                     = lower(replace(replace("${local.resource_group_name}", "_", ""), "-", ""))
  resource_group_name      = data.azurerm_resource_group.main.name
  location                 = data.azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  for_each              = toset(local.applications)
  name                  = "tfstate-${lower(each.value)}"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}