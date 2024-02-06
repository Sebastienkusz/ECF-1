locals {
  build_date = formatdate("YYYY-MM-DD-hhmmss", timestamp())
  project_prefix = lower(replace(replace("${var.project_rg}", "_", ""), "-", ""))
  image_name = "${local.project_prefix}-${var.project_name}-${local.build_date}"
  scripts_path = "${path.root}/scripts"
  files_path = "${path.root}/files"
}

source "azure-arm" "ubuntu" {
  use_azure_cli_auth = true
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id

  managed_image_name                = local.image_name
  managed_image_resource_group_name = var.project_rg

  os_type         = "Linux"
  image_publisher = "canonical"
  image_offer     = "0001-com-ubuntu-server-jammy"
  image_sku       = "22_04-lts"

  build_resource_group_name = var.project_rg
  temp_compute_name         = local.image_name
  temp_nic_name             = local.image_name
  vm_size                   = "Standard_DS2_v2"
}

build {
  sources = ["source.azure-arm.ubuntu"]
  provisioner "shell" {
    environment_vars = [
      "FQDN=${var.project_name}.${local.project_prefix}",
    ]
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
    scripts = [
      "${local.scripts_path}/common/apt_upgrade.sh",
      "${local.scripts_path}/${var.project_name}/install.sh"
    ]
  }
}