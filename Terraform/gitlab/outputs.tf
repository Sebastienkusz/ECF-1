output "admin_ssh" {
  value = "ssh -i ${local_file.admin_rsa_file.filename} -p ${local.ssh_port} ${local.admin_username}@${module.vm.vm_fqdn}"
}

output "vm_fqdn" {
  value = " http://${module.vm.vm_fqdn} "
}

output "first_password" {
  value = " ssh -i ${local_file.admin_rsa_file.filename} ${local.admin_username}@${module.vm.vm_fqdn} sudo grep '^Password' /etc/gitlab/initial_root_password "
}